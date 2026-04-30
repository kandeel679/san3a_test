import '../sources/remote/firebase_source.dart';
import '../models/chat_message_model.dart';

/// Mirrors data/repository/NotificationRepositoryImpl.kt
class NotificationRepository {
  final FirestoreService _firestore;
  static const _notificationsCollection = 'notifications';

  NotificationRepository(this._firestore);

  Stream<List<NotificationModel>> getNotifications(String userId) {
    return _firestore.streamCollection(
      '$_notificationsCollection/$userId/items',
      queryBuilder: (ref) => ref.orderBy('dateTime', descending: true),
    ).map((docs) => docs.map((d) {
      final data = d.data();
      return NotificationModel(
        id: d.id,
        title: data['title'] as String? ?? '',
        caption: data['caption'] as String? ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          (data['dateTime'] as num?)?.toInt() ?? 0,
        ),
      );
    }).toList());
  }

  Stream<int> getUnreadCount(String userId) {
    return _firestore.streamCollection(
      '$_notificationsCollection/$userId/items',
      queryBuilder: (ref) => ref.where('isRead', isEqualTo: false),
    ).map((docs) => docs.length);
  }

  Future<void> addNotification(String userId, String title, String caption) async {
    await _firestore.addToCollection('$_notificationsCollection/$userId/items', {
      'title': title,
      'caption': caption,
      'dateTime': DateTime.now().millisecondsSinceEpoch,
      'isRead': false,
    });
  }

  Future<void> markAllAsRead(String userId) async {
    final docs = await _firestore.streamCollection(
      '$_notificationsCollection/$userId/items',
      queryBuilder: (ref) => ref.where('isRead', isEqualTo: false),
    ).first;
    for (final doc in docs) {
      await _firestore.updateDoc(
        '$_notificationsCollection/$userId/items/${doc.id}',
        {'isRead': true},
      );
    }
  }
}
