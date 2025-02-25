import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:fpdart/fpdart.dart';
import 'package:car_rent/core/error/failure.dart';

abstract interface class MessagesRepository {
  Future<Either<Failure, List<Message>>> fetchMessages();
  Future<Either<Failure, Message>> getMessageById(int id);
  Future<Either<Failure, Unit>> createMessage(Message message);
  Future<Either<Failure, Unit>> updateMessage(int id, Message message);
  Future<Either<Failure, Unit>> deleteMessage(int id);
  Stream<List<int>> getMessagesStream();
}
