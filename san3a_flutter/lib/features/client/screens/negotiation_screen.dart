import 'package:flutter/material.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/sources/remote/api_client.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/l10n/app_localizations.dart';

class NegotiationScreen extends StatefulWidget {
  final String requestId;
  final double currentOffer;
  
  const NegotiationScreen({Key? key, required this.requestId, required this.currentOffer}) : super(key: key);

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final TextEditingController _targetPriceController = TextEditingController();
  final AiRepository _aiRepository = AiRepository(ApiClient());
  
  double? _counterOffer;
  bool _isNegotiating = false;

  void _negotiate() async {
    final target = double.tryParse(_targetPriceController.text);
    if (target == null) return;

    setState(() => _isNegotiating = true);
    
    final counter = await _aiRepository.negotiatePrice(widget.requestId, target);
    
    setState(() {
      _isNegotiating = false;
      _counterOffer = counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('aiNegotiation'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.translate('currentProviderOffer'),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'EGP ${widget.currentOffer}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(t.translate('enterTargetPrice')),
            CustomTextField(
              label: t.translate('targetPrice'),
              controller: _targetPriceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            
            if (_counterOffer != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green[50],
                child: Column(
                  children: [
                    Text(t.translate('aiCounterOffer')),
                    Text(
                      'EGP $_counterOffer',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: t.translate('acceptOffer'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.translate('offerAccepted'))));
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 8),
            ],

            CustomButton(
              text: t.translate('letAiNegotiate'),
              isLoading: _isNegotiating,
              onPressed: _negotiate,
            ),
          ],
        ),
      ),
    );
  }
}
