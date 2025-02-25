import 'package:car_rent/features/messaging/data/datasources/messages_remote_data_source.dart';
import 'package:car_rent/features/messaging/data/models/message_model.dart';
import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:car_rent/features/messaging/domain/repository/messages_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;

  MessagesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Message>>> fetchMessages() async {
    try {
      final messages = await remoteDataSource.fetchMessages();
      return right(messages.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Message>> getMessageById(int id) async {
    try {
      final message = await remoteDataSource.getMessageById(id);
      return right(message.toEntity());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createMessage(Message message) async {
    try {
      await remoteDataSource.createMessage(MessageModel.fromEntity(message));
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMessage(int id, Message message) async {
    try {
      await remoteDataSource.updateMessage(
          id, MessageModel.fromEntity(message));
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(int id) async {
    try {
      await remoteDataSource.deleteMessage(id);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Stream<List<int>> getMessagesStream() {
    return remoteDataSource.getMessagesStream();
  }
}
