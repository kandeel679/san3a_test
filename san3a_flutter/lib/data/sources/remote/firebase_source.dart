import 'package:cloud_firestore/cloud_firestore.dart';

/// Mirrors data/service/firestore/FireStoreServiceImpl.kt
/// Provides a clean abstraction over Firestore for CRUD + streaming.
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get a single document
  Future<Map<String, dynamic>?> getDoc(String path) async {
    final doc = await _firestore.doc(path).get();
    if (doc.exists) return doc.data();
    return null;
  }

  /// Set a document (create or overwrite)
  Future<void> setDoc(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).set(data);
  }

  /// Update a document (partial update)
  Future<void> updateDoc(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).update(data);
  }

  /// Delete a document
  Future<void> deleteDoc(String path) async {
    await _firestore.doc(path).delete();
  }

  /// Add a document to a collection (auto-generated ID)
  Future<String> addToCollection(String path, Map<String, dynamic> data) async {
    final docRef = await _firestore.collection(path).add(data);
    return docRef.id;
  }

  /// Stream a single document
  Stream<Map<String, dynamic>?> streamDoc(String path) {
    return _firestore.doc(path).snapshots().map((snap) => snap.data());
  }

  /// Stream a collection
  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> streamCollection(
    String path, {
    Query<Map<String, dynamic>> Function(CollectionReference<Map<String, dynamic>>)? queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(_firestore.collection(path));
    }
    return query.snapshots().map((snap) => snap.docs);
  }

  /// Stream count of documents in a collection
  Stream<int> streamCountOfCollection(
    String path, {
    Query<Map<String, dynamic>> Function(CollectionReference<Map<String, dynamic>>)? queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(_firestore.collection(path));
    }
    return query.snapshots().map((snap) => snap.docs.length);
  }

  /// Clear all documents in a collection
  Future<void> clearCollection(String path) async {
    final snapshot = await _firestore.collection(path).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  /// Batch write multiple operations
  Future<void> batchWrite(List<BatchOperation> operations) async {
    final batch = _firestore.batch();
    for (final op in operations) {
      batch.set(_firestore.doc(op.path), op.data);
    }
    await batch.commit();
  }
}

class BatchOperation {
  final String path;
  final Map<String, dynamic> data;
  const BatchOperation({required this.path, required this.data});
}
