part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class FetchMessagesEvent extends MessageEvent {
  final bool showloading;

  FetchMessagesEvent({this.showloading = false});
}

class CreateMessageEvent extends MessageEvent {
  final Message message;
  CreateMessageEvent(this.message);
}

class UpdateMessageEvent extends MessageEvent {
  final int id;
  final Message message;
  UpdateMessageEvent(this.id, this.message);
}

class DeleteMessageEvent extends MessageEvent {
  final int id;
  DeleteMessageEvent(this.id);
}
