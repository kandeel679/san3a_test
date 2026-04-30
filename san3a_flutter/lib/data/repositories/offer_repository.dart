import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/offer_model.dart';

class OfferRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _offersCollection = 'offers';

  Future<void> sendOffer(OfferModel offer) async {
    await _firestore.collection(_offersCollection).add(offer.toJson());
  }

  Stream<List<OfferModel>> getOffersForRequest(String requestId) {
    return _firestore
        .collection(_offersCollection)
        .where('requestId', isEqualTo: requestId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OfferModel.fromJson(doc.data(), doc.id)).toList();
    });
  }

  Future<void> acceptOffer(String offerId) async {
    await _firestore.collection(_offersCollection).doc(offerId).update({
      'isAccepted': true,
    });
  }
}
