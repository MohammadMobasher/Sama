import 'package:equatable/equatable.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();
}

class QuoteEventFetch extends QuoteEvent {
  const QuoteEventFetch();

  @override
  List<Object> get props => [];
}
