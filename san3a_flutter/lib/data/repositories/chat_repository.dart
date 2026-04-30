import '../sources/remote/firebase_source.dart';
import '../models/chat_message_model.dart';

/// Mirrors data/repository/MessagingRepositoryImpl.kt
class ChatRepository {
  final FirestoreService _firestore;
  static const _chatsCollection = 'chats';
  static const _messagesSubCollection = 'messages';

  ChatRepository(this._firestore);

  Stream<List<Chat>> getChatsByUserId(String userId) {
    return _firestore.streamCollection(
      _chatsCollection,
      queryBuilder: (ref) => ref.where('usersParticipantIds', arrayContains: userId),
    ).map((docs) {
      return docs.map((d) {
        final data = d.data();
        return Chat(
          id: d.id,
          usersParticipantIds: (data['usersParticipantIds'] as List?)
              ?.map((e) => e.toString())
              .toList() ?? [],
          unreadMessagesCount: (data['unreadMessagesCount'] as num?)?.toInt() ?? 0,
        );
      }).toList();
    });
  }

  Stream<List<Message>> getMessages(String chatId) {
    return _firestore.streamCollection(
      '$_chatsCollection/$chatId/$_messagesSubCollection',
      queryBuilder: (ref) => ref.orderBy('time'),
    ).map((docs) {
      return docs.map((d) {
        final data = d.data();
        MessageContent content;
        final type = data['type'] as String? ?? 'text';
        if (type == 'image') {
          content = ImageContent((data['uris'] as List?)?.map((e) => e.toString()).toList() ?? []);
        } else if (type == 'audio') {
          content = AudioContent(
            url: data['url'] as String? ?? '',
            duration: (data['duration'] as num?)?.toInt() ?? 0,
            waves: (data['waves'] as List?)?.map((e) => (e as num).toDouble()).toList() ?? [],
          );
        } else {
          content = TextContent(data['text'] as String? ?? '');
        }
        return Message(
          id: d.id,
          time: DateTime.fromMillisecondsSinceEpoch((data['time'] as num?)?.toInt() ?? 0),
          senderId: data['senderId'] as String? ?? '',
          receiverId: data['receiverId'] as String? ?? '',
          chatId: chatId,
          messageContent: content,
          seen: data['seen'] as bool? ?? false,
        );
      }).toList();
    });
  }

  Future<void> sendMessage(String chatId, Message message) async {
    final data = <String, dynamic>{
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'time': message.time.millisecondsSinceEpoch,
      'seen': false,
    };
    if (message.messageContent is TextContent) {
      data['type'] = 'text';
      data['text'] = (message.messageContent as TextContent).text;
    } else if (message.messageContent is ImageContent) {
      data['type'] = 'image';
      data['uris'] = (message.messageContent as ImageContent).uris;
    }
    await _firestore.addToCollection('$_chatsCollection/$chatId/$_messagesSubCollection', data);
  }

  Future<String> createChat(List<String> participantIds) async {
    return await _firestore.addToCollection(_chatsCollection, {
      'usersParticipantIds': participantIds,
      'unreadMessagesCount': 0,
    });
  }

  Future<void> deleteChat(String chatId) async {
    await _firestore.deleteDoc('$_chatsCollection/$chatId');
  }
}
