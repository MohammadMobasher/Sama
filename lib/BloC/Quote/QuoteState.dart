import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama/Model/Quote.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteStateEmpty extends QuoteState {}

class QuoteStateLoading extends QuoteState {}

class QuoteStateLoaded extends QuoteState {
  final List<Quote> quotes;

  QuoteStateLoaded({@required this.quotes}) : assert(quotes != null);

  @override
  List<Object> get props => [quotes];
}

class QuoteStateError extends QuoteState {}
