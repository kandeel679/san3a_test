import '../sources/remote/firebase_source.dart';
import '../models/service_model.dart';

/// Mirrors data/repository/ServicesRepositoryImpl.kt
class ServicesRepository {
  final FirestoreService _firestore;
  static const _servicesCollection = 'services';

  ServicesRepository(this._firestore);

  Stream<List<Service>> getAllServices() {
    return _firestore.streamCollection(_servicesCollection).map(
      (docs) => docs.map((d) => Service.fromJson(d.data(), d.id)).toList(),
    );
  }

  Future<Service?> getServiceById(String serviceId) async {
    final data = await _firestore.getDoc('$_servicesCollection/$serviceId');
    if (data == null) return null;
    return Service.fromJson(data, serviceId);
  }

  Future<void> updateNumOfRequests(String serviceId) async {
    // Increment the request count for a service
    final data = await _firestore.getDoc('$_servicesCollection/$serviceId');
    if (data != null) {
      final current = (data['numOfRequests'] as num?)?.toInt() ?? 0;
      await _firestore.updateDoc('$_servicesCollection/$serviceId', {
        'numOfRequests': current + 1,
      });
    }
  }
}
