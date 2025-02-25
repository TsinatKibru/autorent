import 'dart:isolate';

import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/features/messaging/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MessagesRemoteDataSource {
  Future<List<MessageModel>> fetchMessages();
  Future<MessageModel> getMessageById(int id);
  Future<void> createMessage(MessageModel message);
  Future<void> updateMessage(int id, MessageModel message);
  Future<void> deleteMessage(int id);
  Stream<List<int>> getMessagesStream();
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final SupabaseClient supabaseClient;

  MessagesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<MessageModel>> fetchMessages() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        throw const ServerException("User not logged in");
      }

      // Make the request to Supabase
      final response = await supabaseClient
          .from('messages')
          .select('*, sender(*), receiver(*), rental(*)')
          .or('sender.eq.$userId,receiver.eq.$userId')
          .order('timestamp', ascending: false);

      print("Response: $response");

      // Check if the response is a List or Map and handle errors
      if (response is List) {
        if (response.isEmpty) {
          print("No messages found.");
          return [];
        }

        // If it's an error message, handle it here (assuming error messages are returned in a List)
        if (response[0] is Map && response[0].containsKey('error')) {
          final errorMessage = response[0]['error'];
          print("Supabase error: $errorMessage");
          throw ServerException(errorMessage);
        }

        // Map response to MessageModel
        return response.map((message) {
          try {
            return MessageModel.fromJson(message as Map<String, dynamic>);
          } catch (e) {
            print("Error creating MessageModel from: $message");
            rethrow;
          }
        }).toList();
      } else {
        print("Response is not a list. Type: ${response.runtimeType}");
        throw const ServerException("Unexpected response type.");
      }
    } catch (e) {
      print("Error fetching messages: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MessageModel> getMessageById(int id) async {
    try {
      // final response =
      //     await supabaseClient.from('messages').select().eq('id', id).single();
      final response = await supabaseClient
          .from('messages')
          .select('*, sender(*), receiver(*), rental(*)')
          .eq('id', id)
          .single();
      return MessageModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createMessage(MessageModel message) async {
    try {
      final Map<String, dynamic> messageData = {
        "content": message.content,
        "sender": message.sender.id, // Extract sender ID
        "receiver": message.receiver.id, // Extract receiver ID
        "rental": message.rental.id, // Extract rental ID
        "timestamp": message.timestamp.toIso8601String(),
        "is_read": message.isRead
      };

      await supabaseClient.from('messages').insert(messageData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateMessage(int id, MessageModel message) async {
    try {
      await supabaseClient
          .from('messages')
          .update(message.toJson())
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteMessage(int id) async {
    try {
      await supabaseClient.from('messages').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<int>> getMessagesStream() {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      return Stream.error(const ServerException("User not logged in"));
    }

    return supabaseClient.from('messages').stream(primaryKey: ['id']).map(
        (event) => event.map((message) => message['id'] as int).toList());
  }
}
