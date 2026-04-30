/// Mirrors domain/entity/Offer.kt + data/source/remote/requests/dto/OfferDto.kt
class OfferModel {
  final String id;
  final String requestId;
  final String craftsmanId;
  final double price;
  final String preferredDate;
  final String preferredTime;
  final String createdAt;
  final String messageToCustomer;
  final bool isAccepted;

  const OfferModel({
    required this.id,
    required this.requestId,
    required this.craftsmanId,
    required this.price,
    required this.preferredDate,
    required this.preferredTime,
    required this.createdAt,
    required this.messageToCustomer,
    this.isAccepted = false,
  });

  factory OfferModel.fromJson(Map<String, dynamic> data, String id) {
    return OfferModel(
      id: id,
      requestId: data['requestId'] as String? ?? '',
      craftsmanId: data['craftsmanId'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      preferredDate: data['preferredDate'] as String? ?? '',
      preferredTime: data['preferredTime'] as String? ?? '',
      createdAt: data['createdAt'] as String? ?? '',
      messageToCustomer: data['messageToCustomer'] as String? ?? '',
      isAccepted: data['isAccepted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'requestId': requestId,
    'craftsmanId': craftsmanId,
    'price': price,
    'preferredDate': preferredDate,
    'preferredTime': preferredTime,
    'createdAt': createdAt,
    'messageToCustomer': messageToCustomer,
    'isAccepted': isAccepted,
  };
}
