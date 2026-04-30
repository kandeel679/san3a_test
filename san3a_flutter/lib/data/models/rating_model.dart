class RatingModel {
  final String? id;
  final String userId;
  final String craftsmanId;
  final String offerId;
  final double rating;
  final int timestamp;

  RatingModel({
    this.id,
    required this.userId,
    required this.craftsmanId,
    required this.offerId,
    required this.rating,
    required this.timestamp,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json, String id) {
    return RatingModel(
      id: id,
      userId: json['userId'] as String,
      craftsmanId: json['craftsmanId'] as String,
      offerId: json['offerId'] as String,
      rating: (json['rating'] as num).toDouble(),
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'craftsmanId': craftsmanId,
      'offerId': offerId,
      'rating': rating,
      'timestamp': timestamp,
    };
  }
}
