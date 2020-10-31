import 'package:equatable/equatable.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();
}

class PaginationEventMessage extends PaginationEvent {
  @override
  List<Object> get props => null;
}

class SplashEventMessage extends PaginationEvent {
  @override
  List<Object> get props => null;
}

class PaginationEventProfile extends PaginationEvent {
  @override
  List<Object> get props => null;
}

class PaginationEventAboutUs extends PaginationEvent {
  @override
  List<Object> get props => null;
}
