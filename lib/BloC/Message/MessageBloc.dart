import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Message/MessageEvent.dart';
import 'package:sama/BloC/Message/MessageState.dart';
import 'package:sama/Model/Message.dart';
import 'package:sama/Repository/MessageRepository.dart';
import 'package:sama/Utilities/MPref.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MeeageRepository messageRepository;

  MessageBloc({this.messageRepository}) : assert(messageRepository != null);

  bool _hasReachedMax(MessageState state) =>
      state is MessageStateLoaded &&
      (state.hasReachedMax == null ? false : state.hasReachedMax);

  @override
  MessageState get initialState => MessageStateUninitialized();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    final currentState = state;

    if (event is MessageEventForward) {
      yield MessageStateUninitialized();
      var result = await this.messageRepository.Forward(event.vm);
      yield MessageStateReply(result ? true : false);
    }

    if (event is MessageEventReply) {
      yield MessageStateUninitialized();
      var result = await this.messageRepository.Reply(event.vm);
      yield MessageStateReply(result ? true : false);
    }

    if (event is MessageEventInsert) {
      yield MessageStateUninitialized();
      var result = await this.messageRepository.Insert(event.vm);

      yield MessageStateInsert(result ? true : false);
    }

    if (event is MessageEventFetchItem) {
      yield MessageStateUninitialized();

      final message = await messageRepository.getItem(event.messageId,
          messageType: event.messageType);

      yield MessageStateLoaded(
          messages: (currentState as MessageStateLoaded).messages,
          messageType: (currentState as MessageStateLoaded).messageType,
          message: message);
    }

    if (event is MessageEventFetchSend && !_hasReachedMax(currentState)) {
      if (currentState is MessageStateUninitialized ||
          currentState is MessageStateInsert ||
          currentState is MessageStateForward ||
          currentState is MessageStateReply) {
        yield MessageStateUninitialized();
        final messages = await messageRepository.fetchSendMessage(
            page: event.page, vm: event.vm);
        yield MessageStateLoaded(
            messages: messages, hasReachedMax: false, messageType: 1);
      }
      if (currentState is MessageStateLoaded) {
        final messages = await messageRepository.fetchSendMessage(
            page: event.page, vm: event.vm);

        if (currentState.messageType == 0 || event.refreshList == true) {
          yield MessageStateLoaded(
              messages: messages, hasReachedMax: false, messageType: 1);
        } else {
          yield messages.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MessageStateLoaded(
                  messages: currentState.messages + messages,
                  hasReachedMax: false,
                  messageType: 1);
        }
      }
    }

    if (event is MessageEventFetchIncomming && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MessageStateUninitialized ||
            currentState is MessageStateInsert ||
            currentState is MessageStateForward ||
            currentState is MessageStateReply ||
            currentState is MessageStateError) {
          yield MessageStateUninitialized();
          final messages = await messageRepository.fetchIncommingMessage(
              page: event.page, vm: event.vm);
          if (event.page == 1) {
            var lastMessageId = messages.first.mailId;
            MPref.setString('LastMessageId', lastMessageId.toString());
          }
          yield MessageStateLoaded(
              messages: messages, hasReachedMax: false, messageType: 0);
        }
        if (currentState is MessageStateLoaded) {
          final messages = await messageRepository.fetchIncommingMessage(
              page: event.page, vm: event.vm);
          if (currentState.messageType == 1 || event.refreshList == true) {
            yield MessageStateUninitialized();
            yield MessageStateLoaded(
                messages: messages, hasReachedMax: false, messageType: 0);
          } else {
            yield messages.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : MessageStateLoaded(
                    messages: currentState.messages + messages,
                    hasReachedMax: false,
                    messageType: 0);
          }
        }
      } catch (_) {
        yield MessageStateError();
      }
    }
  }
}
