import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/rental.dart';

class Message {
  final int id;
  final Rental rental;
  final Profile sender; // Replace `String senderId` with `Profile sender`
  final Profile receiver; // Replace `String receiverId` with `Profile receiver`
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.rental,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      rental: Rental.fromJson(map['rental']),
      sender: Profile.fromJson(map['sender']), // Deserialize sender
      receiver: Profile.fromJson(map['receiver']), // Deserialize receiver
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rental': rental.toJson(),
      'sender': sender.toJson(), // Serialize sender
      'receiver': receiver.toJson(), // Serialize receiver
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
    };
  }

  @override
  String toString() {
    return 'Message(id: $id, rental: $rental, sender: $sender, receiver: $receiver, '
        'content: $content, timestamp: $timestamp, isRead: $isRead)';
  }

  Message copyWith({
    int? id,
    Rental? rental,
    Profile? sender,
    Profile? receiver,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      rental: rental ?? this.rental,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}
