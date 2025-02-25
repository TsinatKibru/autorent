import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/features/messaging/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required int id,
    required Rental rental,
    required Profile sender,
    required Profile receiver,
    required String content,
    required DateTime timestamp,
    required bool isRead,
  }) : super(
          id: id,
          rental: rental,
          sender: sender,
          receiver: receiver,
          content: content,
          timestamp: timestamp,
          isRead: isRead,
        );

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    if (map['rental'] is! Map<String, dynamic>) {
      // print("Invalid rental data: ${map['rental']}");
      throw Exception("Invalid rental data: ${map['rental']}");
    }

    // Validate the 'sender' field
    if (map['sender'] is! Map<String, dynamic>) {
      // print("Invalid sender data: ${map['sender']}");
      throw Exception("Invalid sender data: ${map['sender']}");
    }
    // print(" receiver data: ${map['receiver']}");
    // Validate the 'receiver' field
    if (map['receiver'] is! Map<String, dynamic>) {
      // print("Invalid receiver data: ${map['receiver']}");
      throw Exception("Invalid receiver data: ${map['receiver']}");
    }

    // Optional: Check if fields are present and handle null gracefully
    String content = map['content'] ?? ''; // Default to empty string if missing
    bool isRead = map['is_read'] ?? false; // Default to false if missing
    DateTime timestamp = DateTime.tryParse(map['timestamp'] ?? '') ??
        DateTime.now(); // Default to current time if invalid

    // Proceed with constructing the MessageModel object

    return MessageModel(
      id: map['id'] ?? 0, // Default to 0 if 'id' is missing
      rental: Rental.fromJson(
          map['rental']), // Assuming Rental.fromJson handles null well
      sender: Profile.fromJson(
          map['sender']), // Assuming Profile.fromJson handles null well
      receiver: Profile.fromJson(
          map['receiver']), // Assuming Profile.fromJson handles null well
      content: content,
      timestamp: timestamp,
      isRead: isRead,
    );
  }

  Message toEntity() {
    return Message(
      id: id,
      rental: rental,
      sender: sender,
      receiver: receiver,
      content: content,
      timestamp: timestamp,
      isRead: isRead,
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      rental: message.rental,
      sender: message.sender,
      receiver: message.receiver,
      content: message.content,
      timestamp: message.timestamp,
      isRead: message.isRead,
    );
  }
}
