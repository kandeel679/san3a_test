/// Mirrors domain/entity/Message.kt
sealed class MessageContent {
  const MessageContent();
}

class TextContent extends MessageContent {
  final String text;
  const TextContent(this.text);
}

class AudioContent extends MessageContent {
  final String url;
  final int duration;
  final List<double> waves;
  const AudioContent({required this.url, required this.duration, required this.waves});
}

class ImageContent extends MessageContent {
  final List<String> uris;
  const ImageContent(this.uris);
}

class Message {
  final String id;
  final DateTime time;
  final String senderId;
  final String receiverId;
  final String chatId;
  final MessageContent messageContent;
  final bool seen;

  const Message({
    this.id = '',
    required this.time,
    required this.senderId,
    required this.receiverId,
    required this.chatId,
    required this.messageContent,
    this.seen = false,
  });
}

/// Mirrors domain/entity/Chat.kt
class Chat {
  final String id;
  final List<String> usersParticipantIds;
  final Message? lastMessage;
  final int unreadMessagesCount;

  const Chat({
    this.id = '',
    required this.usersParticipantIds,
    this.lastMessage,
    this.unreadMessagesCount = 0,
  });
}

/// Mirrors domain/entity/Notification.kt
class NotificationModel {
  final String id;
  final String title;
  final String caption;
  final DateTime dateTime;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.caption,
    required this.dateTime,
  });
}

/// Mirrors domain/entity/Stats.kt
class Stats {
  final String userId;
  final int jobsDone;
  final double earnings;
  final double rating;

  const Stats({
    required this.userId,
    this.jobsDone = 0,
    this.earnings = 0.0,
    this.rating = 0.0,
  });
}

/// Mirrors domain/entity/Governorate.kt & City.kt
class Governorate {
  final int id;
  final String name;
  const Governorate({required this.id, required this.name});
}

class City {
  final int id;
  final String name;
  const City({required this.id, required this.name});
}
