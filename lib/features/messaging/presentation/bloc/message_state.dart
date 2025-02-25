part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoadSuccess extends MessageState {
  final List<Message> messages;
  MessageLoadSuccess(this.messages);
}

class MessageFailure extends MessageState {
  final String message;
  MessageFailure(this.message);
}
