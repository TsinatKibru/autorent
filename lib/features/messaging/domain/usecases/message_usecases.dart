import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:car_rent/features/messaging/domain/repository/messages_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';

class FetchMessages implements Usecase<List<Message>, NoParams> {
  final MessagesRepository repository;

  FetchMessages(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(NoParams params) async {
    return await repository.fetchMessages();
  }
}

class CreateMessage implements Usecase<Unit, Message> {
  final MessagesRepository repository;

  CreateMessage(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Message message) async {
    return await repository.createMessage(message);
  }
}

class UpdateMessage implements Usecase<Unit, UpdateMessageParams> {
  final MessagesRepository repository;

  UpdateMessage(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateMessageParams params) async {
    return await repository.updateMessage(params.id, params.message);
  }
}

class DeleteMessage implements Usecase<Unit, int> {
  final MessagesRepository repository;

  DeleteMessage(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteMessage(id);
  }
}

class UpdateMessageParams {
  final int id;
  final Message message;

  UpdateMessageParams({required this.id, required this.message});
}
