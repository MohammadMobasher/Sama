import 'package:equatable/equatable.dart';

class Part extends Equatable {
  int partId;
  String title;
  int deputyId;

  Part({this.partId, this.title, this.deputyId});

  Part.fromJson(Map<String, dynamic> json) {
    partId = json['part_id'];
    title = json['title'];
    deputyId = json['deputy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_id'] = this.partId;
    data['title'] = this.title;
    data['deputy_id'] = this.deputyId;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [partId, title, deputyId];
}
