import '../sources/remote/api_client.dart';

class AiRepository {
  final ApiClient _apiClient;

  AiRepository(this._apiClient);

  Future<String> getChatbotResponse(String userMessage) async {
    try {
      final response = await _apiClient.sendChatbotMessage(userMessage);
      return response['reply'] as String;
    } catch (e) {
      return "Sorry, I am having trouble connecting to the server. Please try again.";
    }
  }

  Future<Map<String, double>> getPriceRecommendation(String serviceId, String location, String description) async {
    try {
      final params = {'location': location, 'description': description};
      final response = await _apiClient.getPriceRecommendation(serviceId, params);
      return {
        'minPrice': (response['minPrice'] as num).toDouble(),
        'maxPrice': (response['maxPrice'] as num).toDouble(),
      };
    } catch (e) {
      // Return a mock range if the API fails
      return {'minPrice': 100.0, 'maxPrice': 300.0};
    }
  }

  Future<double> negotiatePrice(String requestId, double targetPrice) async {
    try {
      final response = await _apiClient.initiateNegotiation(requestId, targetPrice);
      return (response['counterOffer'] as num).toDouble();
    } catch (e) {
      return targetPrice + 50.0; // Mock counter offer
    }
  }
}
