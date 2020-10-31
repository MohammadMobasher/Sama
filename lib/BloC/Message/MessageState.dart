import 'package:equatable/equatable.dart';
import 'package:sama/Model/Message.dart';

abstract class MessageState extends Equatable {
  
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageStateLoading extends MessageState {}

class MessageStatefetchItemCompleted extends MessageState {
  final Message message;

  MessageStatefetchItemCompleted(this.message) : assert(message != null);
  @override
  List<Object> get props => [message];
}

class MessageStateForward extends MessageState {
  final bool IsSuccess;

  MessageStateForward(this.IsSuccess);

  @override
  List<Object> get props => [IsSuccess];
}

class MessageStateReply extends MessageState {
  final bool IsSuccess;

  MessageStateReply(this.IsSuccess);

  @override
  List<Object> get props => [IsSuccess];
}

class MessageStateInsert extends MessageState {
  final bool IsSuccess;

  MessageStateInsert(this.IsSuccess);

  @override
  List<Object> get props => [IsSuccess];
}

class MessageStateUninitialized extends MessageState {}

class MessageStateLoaded extends MessageState {
  final List<Message> messages;
  final Message message;
  final bool hasReachedMax;
  final int messageType;

  MessageStateLoaded(
      {this.messages, this.hasReachedMax, this.messageType, this.message});

  MessageStateLoaded copyWith(
      {List<Message> messages, bool hasReachedMax, int messageType}) {
    return MessageStateLoaded(
        messages: messages ?? this.messages,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        messageType: messageType);
  }

  @override
  List<Object> get props => [messages];
}

class MessageStateError extends MessageState {}
