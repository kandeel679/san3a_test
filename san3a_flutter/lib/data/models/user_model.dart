/// Mirrors domain/entity/AccountSetupStep.kt
enum AccountSetupStep {
  accountType,
  services,
  location,
  personalInfo,
  workShowcase,
  uploadNationalId,
  completed;

  static AccountSetupStep fromString(String? value) {
    switch (value) {
      case 'ACCOUNT_TYPE': return AccountSetupStep.accountType;
      case 'SERVICES': return AccountSetupStep.services;
      case 'LOCATION': return AccountSetupStep.location;
      case 'PERSONAL_INFO': return AccountSetupStep.personalInfo;
      case 'WORK_SHOWCASE': return AccountSetupStep.workShowcase;
      case 'UPLOAD_NATIONAL_ID': return AccountSetupStep.uploadNationalId;
      case 'COMPLETED': return AccountSetupStep.completed;
      default: return AccountSetupStep.accountType;
    }
  }

  String toFirestore() => name.toUpperCase().replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]}_${m[2]}'
  ).toUpperCase();
}

/// Mirrors domain/entity/User.kt
enum AccountType {
  customer,
  craftsman;

  static AccountType fromString(String? value) {
    if (value == 'CRAFTSMAN') return AccountType.craftsman;
    return AccountType.customer;
  }

  String toFirestore() => name.toUpperCase();
}

class Location {
  final int governmentId;
  final int cityId;
  final String addressInDetails;

  const Location({
    required this.governmentId,
    required this.cityId,
    required this.addressInDetails,
  });

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(
      governmentId: (data['governmentId'] as num?)?.toInt() ?? 0,
      cityId: (data['cityId'] as num?)?.toInt() ?? 0,
      addressInDetails: (data['addressInDetails'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'governmentId': governmentId,
    'cityId': cityId,
    'addressInDetails': addressInDetails,
  };
}

class User {
  final String id;
  final String phone;
  final String fullName;
  final String? profilePhoto;
  final String nationalIdFrontImage;
  final String nationalIdBackImage;
  final String workDescription;
  final AccountType accountType;
  final Location location;

  const User({
    required this.id,
    required this.phone,
    required this.fullName,
    this.profilePhoto,
    required this.nationalIdFrontImage,
    required this.nationalIdBackImage,
    required this.workDescription,
    required this.accountType,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      phone: id,
      fullName: data['fullName']?.toString() ?? '',
      profilePhoto: data['profilePhoto']?.toString(),
      nationalIdFrontImage: data['nationalIdFrontImage']?.toString() ?? '',
      nationalIdBackImage: data['nationalIdBackImage']?.toString() ?? '',
      workDescription: data['workDescription']?.toString() ?? '',
      accountType: AccountType.fromString(data['accountType']?.toString()),
      location: Location.fromJson(
          (data['location'] as Map<String, dynamic>?) ?? {}),
    );
  }
}
