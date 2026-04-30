import 'package:cloud_firestore/cloud_firestore.dart';
import '../sources/remote/firebase_source.dart';
import '../models/service_request_model.dart';
import '../models/offer_model.dart';

/// Mirrors data/repository/RequestsRepositoryImpl.kt
class ServiceRequestRepository {
  final FirestoreService _firestore;

  static const _requestsCollection = 'service_requests';
  static const _offersCollection = 'offers';

  ServiceRequestRepository(this._firestore);

  Future<String> createRequest(ServiceRequestModel request) async {
    return await _firestore.addToCollection(_requestsCollection, request.toJson());
  }

  Future<ServiceRequestModel?> getRequestById(String requestId) async {
    final data = await _firestore.getDoc('$_requestsCollection/$requestId');
    if (data == null) return null;
    return ServiceRequestModel.fromJson(data, requestId);
  }

  Future<void> deleteRequest(String requestId) async {
    await _firestore.deleteDoc('$_requestsCollection/$requestId');
  }

  Future<void> assignCraftsman(String requestId, String craftsmanId) async {
    await _firestore.updateDoc('$_requestsCollection/$requestId', {
      'selectedCraftsmanId': craftsmanId,
    });
  }

  Future<void> cancelRequest(String requestId) async {
    await _firestore.updateDoc('$_requestsCollection/$requestId', {
      'requestStatus': 'CANCELLED',
    });
  }

  Future<void> markAsDone(String requestId) async {
    await _firestore.updateDoc('$_requestsCollection/$requestId', {
      'requestStatus': 'COMPLETED',
    });
  }

  Stream<List<ServiceRequestModel>> getCustomerRequests(String userId) {
    return _firestore.streamCollection(
      _requestsCollection,
      queryBuilder: (ref) => ref
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true),
    ).map((docs) => docs
        .map((d) => ServiceRequestModel.fromJson(d.data(), d.id))
        .toList());
  }

  Stream<List<ServiceRequestModel>> getAvailableJobs(String userId) {
    return _firestore.streamCollection(
      _requestsCollection,
      queryBuilder: (ref) => ref
          .where('requestStatus', isEqualTo: 'ONGOING')
          .orderBy('createdAt', descending: true),
    ).map((docs) => docs
        .where((d) => d.data()['userId'] != userId)
        .map((d) => ServiceRequestModel.fromJson(d.data(), d.id))
        .toList());
  }

  Stream<List<ServiceRequestModel>> getRecentRelatedJobs(List<String> serviceIds, String userId) {
    if (serviceIds.isEmpty) return Stream.value([]);
    return _firestore.streamCollection(
      _requestsCollection,
      queryBuilder: (ref) => ref
          .where('requestStatus', isEqualTo: 'ONGOING')
          .where('serviceId', whereIn: serviceIds)
          .orderBy('createdAt', descending: true),
    ).map((docs) => docs
        .where((d) => d.data()['userId'] != userId)
        .map((d) => ServiceRequestModel.fromJson(d.data(), d.id))
        .toList());
  }

  // --- Offers ---
  Future<void> addOffer(OfferModel offer) async {
    await _firestore.addToCollection(_offersCollection, offer.toJson());
  }

  Stream<List<OfferModel>> getOffersForRequest(String requestId) {
    return _firestore.streamCollection(
      _offersCollection,
      queryBuilder: (ref) => ref.where('requestId', isEqualTo: requestId),
    ).map((docs) => docs.map((d) => OfferModel.fromJson(d.data(), d.id)).toList());
  }

  Stream<int> getOffersCount(String requestId) {
    return _firestore.streamCountOfCollection(
      _offersCollection,
      queryBuilder: (ref) => ref.where('requestId', isEqualTo: requestId),
    );
  }

  Future<void> acceptOffer(String offerId) async {
    await _firestore.updateDoc('$_offersCollection/$offerId', {'isAccepted': true});
  }

  Stream<OfferModel?> getCraftManOfferOnRequest(String craftsmanId, String requestId) {
    return _firestore.streamCollection(
      _offersCollection,
      queryBuilder: (ref) => ref
          .where('craftsmanId', isEqualTo: craftsmanId)
          .where('requestId', isEqualTo: requestId),
    ).map((docs) {
      if (docs.isEmpty) return null;
      final d = docs.first;
      return OfferModel.fromJson(d.data(), d.id);
    });
  }

  Stream<OfferModel?> getAcceptedOfferOnRequest(String requestId) {
    return _firestore.streamCollection(
      _offersCollection,
      queryBuilder: (ref) => ref
          .where('requestId', isEqualTo: requestId)
          .where('isAccepted', isEqualTo: true),
    ).map((docs) {
      if (docs.isEmpty) return null;
      final d = docs.first;
      return OfferModel.fromJson(d.data(), d.id);
    });
  }
}
