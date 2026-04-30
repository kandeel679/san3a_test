import 'package:flutter/material.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/sources/remote/api_client.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

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
    // Implement Service Request submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Service Request Submitted!'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Describe your problem:', style: TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: 'Description',
              controller: _descriptionController,
            ),
            const SizedBox(height: 16),
            const Text('Location Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            CustomTextField(
              label: 'Location',
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
                    const Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('AI Price Recommendation', style: TextStyle(fontWeight: FontWeight.bold)),
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
              text: _priceRecommendation == null ? 'Get AI Price Estimate' : 'Submit Request',
              isLoading: _isLoadingPrice,
              onPressed: _priceRecommendation == null ? _getRecommendation : _submitRequest,
            ),
          ],
        ),
      ),
    );
  }
}
