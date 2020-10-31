import 'package:flutter/cupertino.dart';
import 'package:sama/DataProvider/QuoteProvider.dart';
import 'package:sama/Model/Quote.dart';

class QuoteRepository {
  final QuoteProvider quoteProvider;

  QuoteRepository({@required this.quoteProvider})
      : assert((quoteProvider != null));

  Future<List<Quote>> fetchQuote() async {
    return await quoteProvider.fetchQuote();
  }
}
