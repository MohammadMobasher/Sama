import 'package:equatable/equatable.dart';

class Deputy extends Equatable {
  int deputyId;
  String title;

  Deputy({this.deputyId, this.title});

  Deputy.fromJson(Map<String, dynamic> json) {
    deputyId = json['deputy_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deputy_id'] = this.deputyId;
    data['title'] = this.title;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [deputyId, title];
}
