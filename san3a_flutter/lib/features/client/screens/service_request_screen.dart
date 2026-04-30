import 'package:flutter/material.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/sources/remote/api_client.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/l10n/app_localizations.dart';

class ServiceRequestScreen extends StatefulWidget {
  final String serviceId;
  const ServiceRequestScreen({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  final AiRepository _aiRepository = AiRepository(ApiClient());
  
  Map<String, double>? _priceRecommendation;
  bool _isLoadingPrice = false;

  void _getRecommendation() async {
    setState(() => _isLoadingPrice = true);
    
    final recommendation = await _aiRepository.getPriceRecommendation(
      widget.serviceId,
      _locationController.text,
      _descriptionController.text,
    );
    
    setState(() {
      _isLoadingPrice = false;
      _priceRecommendation = recommendation;
    });
  }

  void _submitRequest() {
    final t = AppLocalizations.of(context);
    // Implement Service Request submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.translate('serviceRequestSubmitted')))
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('createRequest'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.translate('describeYourProblem'), style: const TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: t.translate('description'),
              controller: _descriptionController,
            ),
            const SizedBox(height: 16),
            Text(t.translate('locationDetails'), style: const TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: t.translate('location'),
              controller: _locationController,
            ),
            const SizedBox(height: 24),
            
            if (_priceRecommendation != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(t.translate('aiPriceRecommendation'), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'EGP ${_priceRecommendation!['minPrice']} - EGP ${_priceRecommendation!['maxPrice']}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            CustomButton(
              text: _priceRecommendation == null ? t.translate('getAiPriceEstimate') : t.translate('submitRequest'),
              isLoading: _isLoadingPrice,
              onPressed: _priceRecommendation == null ? _getRecommendation : _submitRequest,
            ),
          ],
        ),
      ),
    );
  }
}
