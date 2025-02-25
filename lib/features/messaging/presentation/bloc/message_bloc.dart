import 'package:bloc/bloc.dart';
import 'package:car_rent/core/usecase/usecase.dart';

import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:car_rent/features/messaging/domain/repository/messages_repository.dart';
import 'package:car_rent/features/messaging/domain/usecases/message_usecases.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final FetchMessages _fetchMessages;
  final CreateMessage _createMessage;
  final UpdateMessage _updateMessage;
  final DeleteMessage _deleteMessage;
  final MessagesRepository _messagesRepository;

  MessageBloc({
    required FetchMessages fetchMessages,
    required CreateMessage createMessage,
    required UpdateMessage updateMessage,
    required DeleteMessage deleteMessage,
    required MessagesRepository messagesRepository,
  })  : _fetchMessages = fetchMessages,
        _createMessage = createMessage,
        _updateMessage = updateMessage,
        _deleteMessage = deleteMessage,
        _messagesRepository = messagesRepository,
        super(MessageInitial()) {
    on<FetchMessagesEvent>(_onFetchMessages);
    on<CreateMessageEvent>(_onCreateMessage);
    on<UpdateMessageEvent>(_onUpdateMessage);
    on<DeleteMessageEvent>(_onDeleteMessage);

    // Listen to real-time updates
    // _messagesRepository.getMessagesStream().listen((messages) {
    //   // emit(MessageLoadSuccess(messages));
    //   add(FetchMessagesEvent());
    // });
    _messagesRepository.getMessagesStream().listen((messageIds) {
      add(FetchMessagesEvent()); // Fetch updated messages
    });
  }

  void _onFetchMessages(
      FetchMessagesEvent event, Emitter<MessageState> emit) async {
    if (event.showloading) {
      emit(MessageLoading());
    }
    final res = await _fetchMessages(NoParams());
    res.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (messages) => emit(MessageLoadSuccess(messages)),
    );
  }

  void _onCreateMessage(
      CreateMessageEvent event, Emitter<MessageState> emit) async {
    final res = await _createMessage(event.message);
    res.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => add(FetchMessagesEvent()),
    );
  }

  void _onUpdateMessage(
      UpdateMessageEvent event, Emitter<MessageState> emit) async {
    final res = await _updateMessage(
        UpdateMessageParams(id: event.id, message: event.message));
    res.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => add(FetchMessagesEvent()),
    );
  }

  void _onDeleteMessage(
      DeleteMessageEvent event, Emitter<MessageState> emit) async {
    final res = await _deleteMessage(event.id);
    res.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => add(FetchMessagesEvent()),
    );
  }
}
