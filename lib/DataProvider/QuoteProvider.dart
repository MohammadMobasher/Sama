import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:sama/Model/Quote.dart';

class QuoteProvider {
  final _baseUrl = 'https://quote-garden.herokuapp.com';
  final http.Client httpClient;

  QuoteProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Quote>> fetchQuote() async {
    final url = _baseUrl + "/api/v2/quotes?page=1&limit=20";
    http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      print(e);
    }

    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
    List<Quote> quotes;
    try {
      quotes =
          (json['quotes'] as List).map((item) => Quote.fromJson(item)).toList();
    } catch (e) {
      print(e);
    }
    return quotes;
  }
}
