import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Quote/QuoteEvent.dart';
import 'package:sama/BloC/Quote/QuoteState.dart';
import 'package:sama/Model/Quote.dart';
import 'package:sama/Repository/QuoteRepository.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteBloc({this.quoteRepository}) : assert(quoteRepository != null);

  @override
  QuoteState get initialState => QuoteStateEmpty();

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    if (event is QuoteEventFetch) {
      yield QuoteStateLoading();

      try {
        final List<Quote> quotea = await quoteRepository.fetchQuote();

        yield QuoteStateLoaded(quotes: quotea);
      } catch (_) {
        yield QuoteStateError();
      }
    }
  }
}
