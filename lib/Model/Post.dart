import 'package:equatable/equatable.dart';

class Post extends Equatable {
  int postId;
  String title;
  int levelId;
  int deputyId;

  Post({this.postId, this.title, this.levelId, this.deputyId});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    title = json['title'];
    levelId = json['level_id'];
    deputyId = json['deputy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['title'] = this.title;
    data['level_id'] = this.levelId;
    data['deputy_id'] = this.deputyId;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [postId, title, levelId, deputyId];
}
