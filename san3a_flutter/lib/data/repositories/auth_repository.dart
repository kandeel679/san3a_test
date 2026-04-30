import '../sources/remote/firebase_source.dart';
import '../sources/remote/api_client.dart';
import '../sources/local/local_storage.dart';
import '../models/user_model.dart';

/// Mirrors data/repository/UserRepositoryImpl.kt
class AuthRepository {
  final FirestoreService _firestore;
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  static const _usersCollection = 'users';
  static const _offeredServicesCollection = 'offeredServices';
  static const _requestedServicesPath = 'requestedServices';
  static const _ratingsCollection = 'ratings';
  static const _earningsCollection = 'earnings';
  static const _jobsDoneCollection = 'jobs_done';

  AuthRepository(this._firestore, this._apiClient, this._localStorage);

  Future<void> sendOtp(String phone) async {
    await _apiClient.sendOtpMessage(phone, 'Your San3a verification code');
  }

  Future<void> addUser(String phone) async {
    await _firestore.setDoc('$_usersCollection/$phone', {
      'phone': phone,
      'currentStep': 'ACCOUNT_TYPE',
    });
  }

  Future<void> saveAccountType(String phone, AccountType type) async {
    await _firestore.updateDoc('$_usersCollection/$phone', {
      'accountType': type.toFirestore(),
    });
  }

  Future<void> updateUserProgress(String phone, AccountSetupStep step) async {
    await _firestore.updateDoc('$_usersCollection/$phone', {
      'currentStep': step.name.toUpperCase(),
    });
  }

  Future<void> saveServices(String phone, List<String> services, bool isCraftsman) async {
    final path = isCraftsman
        ? '$_usersCollection/$phone/$_offeredServicesCollection'
        : '$_usersCollection/$phone/$_requestedServicesPath';
    await _firestore.clearCollection(path);
    final operations = services
        .map((s) => BatchOperation(path: '$path/$s', data: {}))
        .toList();
    await _firestore.batchWrite(operations);
  }

  Future<void> updateLocation(String phone, Location location) async {
    await _firestore.updateDoc('$_usersCollection/$phone', {
      'location': location.toJson(),
    });
  }

  Future<void> updatePersonalInfo(String phone, String fullName, String? profilePhoto) async {
    final data = <String, dynamic>{'fullName': fullName};
    if (profilePhoto != null) data['profilePhoto'] = profilePhoto;
    await _firestore.updateDoc('$_usersCollection/$phone', data);
  }

  Future<void> updateWorkShowcase(String phone, List<String>? workMedia, String workDescription) async {
    final data = <String, dynamic>{'workDescription': workDescription};
    if (workMedia != null) data['workMedia'] = workMedia;
    await _firestore.updateDoc('$_usersCollection/$phone', data);
  }

  Future<void> updateNationalIdImages(String phone, String? frontUrl, String? backUrl) async {
    final data = <String, dynamic>{};
    if (frontUrl != null) data['nationalIdFrontImage'] = frontUrl;
    if (backUrl != null) data['nationalIdBackImage'] = backUrl;
    await _firestore.updateDoc('$_usersCollection/$phone', data);
  }

  Future<AccountSetupStep> getUserProgress(String phone) async {
    final data = await _firestore.getDoc('$_usersCollection/$phone');
    if (data == null) return AccountSetupStep.accountType;
    return AccountSetupStep.fromString(data['currentStep']?.toString());
  }

  Future<User> getUser(String phone) async {
    final data = await _firestore.getDoc('$_usersCollection/$phone');
    if (data == null) throw Exception('User not found: $phone');
    return User.fromJson(data, phone);
  }

  Future<void> addRatingForCraftsman(String userId, String craftsmanId, String offerId, double rating) async {
    await _firestore.setDoc(
      '$_usersCollection/$craftsmanId/$_ratingsCollection/$userId-$offerId',
      {'rating': rating, 'offerId': offerId, 'userId': userId, 'timestamp': DateTime.now().millisecondsSinceEpoch},
    );
  }

  Stream<double> getRatingForCraftsman(String craftsmanId) {
    return _firestore
        .streamCollection('$_usersCollection/$craftsmanId/$_ratingsCollection')
        .map((docs) {
      if (docs.isEmpty) return 0.0;
      final ratings = docs.map((d) => (d.data()['rating'] as num?)?.toDouble() ?? 0.0).toList();
      return ratings.reduce((a, b) => a + b) / ratings.length;
    });
  }

  Future<void> updateEarningsForCraftsman(String craftsmanId, String userId, String requestId, double earnings) async {
    await _firestore.setDoc(
      '$_usersCollection/$craftsmanId/$_earningsCollection/$userId-$requestId',
      {'earnings': earnings},
    );
  }

  Stream<double> getEarningsForCraftsman(String craftsmanId) {
    return _firestore
        .streamCollection('$_usersCollection/$craftsmanId/$_earningsCollection')
        .map((docs) {
      if (docs.isEmpty) return 0.0;
      return docs.map((d) => (d.data()['earnings'] as num?)?.toDouble() ?? 0.0).reduce((a, b) => a + b);
    });
  }

  Future<void> incrementJobsDone(String craftsmanId, String requestId, String userId) async {
    await _firestore.setDoc(
      '$_usersCollection/$craftsmanId/$_jobsDoneCollection/$requestId',
      {'userId': userId},
    );
  }

  Stream<int> getJobsDoneForCraftsman(String craftsmanId) {
    return _firestore.streamCountOfCollection('$_usersCollection/$craftsmanId/$_jobsDoneCollection');
  }

  // LocalStorage delegates
  Future<void> savePhone(String phone) => _localStorage.savePhone(phone);
  Future<String?> getPhone() => _localStorage.getPhone();
  Future<void> setOnboardingCompleted(bool v) => _localStorage.setOnboardingCompleted(v);
  Future<bool> isOnboardingCompleted() => _localStorage.isOnboardingCompleted();
}
