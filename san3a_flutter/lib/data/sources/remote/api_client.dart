import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String otpBaseUrl = 'https://www.whatsapp.api.funtaste.xyz';
  // Placeholder for the Python backend mentioned in the prompt
  static const String aiBaseUrl = 'https://api.san3a-ai-placeholder.com';

  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> sendOtpMessage(String phone, String message) async {
    final response = await _client.post(
      Uri.parse('$otpBaseUrl/api/send-message'),
      headers: {
        'Content-Type': 'application/json',
        // Example token extracted from Kotlin
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODhlNWQ3ZTFlNjZkZWQ5NmU0MTdjNTgiLCJpYXQiOjE3NTQzMDc2MTF9.0AVjQpt4ahSlwUIfyXA0JuYhm9ppJrH1FZVXu2PdLns',
      },
      body: jsonEncode({
        'phone': phone,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw Exception('Invalid phone number');
    } else {
      throw Exception('Server exception');
    }
  }

  // --- AI Features (Placeholder Endpoints) ---

  Future<Map<String, dynamic>> sendChatbotMessage(String message) async {
    final response = await _client.post(
      Uri.parse('$aiBaseUrl/api/chatbot/message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to communicate with AI Chatbot');
  }

  Future<Map<String, dynamic>> getPriceRecommendation(String serviceId, Map<String, dynamic> parameters) async {
    final response = await _client.post(
      Uri.parse('$aiBaseUrl/api/ml/price-recommendation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'serviceId': serviceId, 'parameters': parameters}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to get price recommendation');
  }

  Future<Map<String, dynamic>> initiateNegotiation(String requestId, double targetPrice) async {
    final response = await _client.post(
      Uri.parse('$aiBaseUrl/api/rl/negotiate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'requestId': requestId, 'targetPrice': targetPrice}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Failed to initiate negotiation');
  }
}
