import 'package:sama/Model/Deputy.dart';

import 'Part.dart';
import 'Post.dart';

class User {
  int userId;
  String username;
  String fullname;
  String lastname;
  String pathCover;
  int deputyId;
  int partId;
  int postId;
  Part part;
  Post post;
  Deputy deputy;

  User(
      {this.userId,
      this.username,
      this.fullname,
      this.lastname,
      this.pathCover,
      this.deputyId,
      this.partId,
      this.postId,
      this.part,
      this.post,
      this.deputy});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'] != null ? json['username'] : null;
    fullname = json['fullname'];
    lastname = json['lastname'];
    pathCover = json['pathCover'] != null ? json['pathCover'] : null;
    deputyId = json['deputy_id'] != null ? json['deputy_id'] : null;
    partId = json['part_id'] != null ? json['part_id'] : null;
    postId = json['post_id'] != null ? json['post_id'] : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    deputy =
        json['deputy'] != null ? new Deputy.fromJson(json['deputy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['lastname'] = this.lastname;
    data['pathCover'] = this.pathCover;
    data['deputy_id'] = this.deputyId;
    data['part_id'] = this.partId;
    data['post_id'] = this.postId;
    if (this.part != null) {
      data['part'] = this.part.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}
