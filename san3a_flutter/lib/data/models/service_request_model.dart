/// Mirrors domain/entity/RequestService.kt
enum RequestStatus {
  ongoing,
  completed,
  cancelled;

  static RequestStatus fromString(String? value) {
    switch (value) {
      case 'COMPLETED': return RequestStatus.completed;
      case 'CANCELLED': return RequestStatus.cancelled;
      default: return RequestStatus.ongoing;
    }
  }

  String toFirestore() => name.toUpperCase();
}

class ServiceRequestModel {
  final String id;
  final String userId;
  final RequestStatus requestStatus;
  final String serviceId;
  final String title;
  final String description;
  final int governorateId;
  final int cityId;
  final String locationDetails;
  final String? time;
  final List<String> image;
  final String? selectedCraftsmanId;
  final int createdAt;

  const ServiceRequestModel({
    required this.id,
    required this.userId,
    required this.requestStatus,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.governorateId,
    required this.cityId,
    required this.locationDetails,
    this.time,
    required this.image,
    this.selectedCraftsmanId,
    required this.createdAt,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> data, String id) {
    return ServiceRequestModel(
      id: id,
      userId: data['userId'] as String? ?? '',
      requestStatus: RequestStatus.fromString(data['requestStatus'] as String?),
      serviceId: data['serviceId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      governorateId: (data['governorateId'] as num?)?.toInt() ?? 0,
      cityId: (data['cityId'] as num?)?.toInt() ?? 0,
      locationDetails: data['locationDetails'] as String? ?? '',
      time: data['time'] as String?,
      image: (data['image'] as List?)?.map((e) => e.toString()).toList() ?? [],
      selectedCraftsmanId: data['selectedCraftsmanId'] as String?,
      createdAt: (data['createdAt'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'governorateId': governorateId,
      'cityId': cityId,
      'locationDetails': locationDetails,
      'image': image,
      'userId': userId,
      'serviceId': serviceId,
      'requestStatus': requestStatus.toFirestore(),
      'createdAt': createdAt,
    };
    if (selectedCraftsmanId != null) map['selectedCraftsmanId'] = selectedCraftsmanId;
    if (time != null) map['time'] = time;
    return map;
  }
}
