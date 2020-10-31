import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final id;
  final String quoteText;
  final String quoteAuthor;

  Quote({this.id, this.quoteText, this.quoteAuthor});

  @override
  List<Object> get props => [id, quoteText, quoteAuthor];

  static Quote fromJson(dynamic json) {
    return Quote(
      id: json['_id'],
      quoteText: json['quoteText'],
      quoteAuthor: json['quoteAuthor'],
    );

  }
}
