import 'package:equatable/equatable.dart';
import 'package:sama/Model/Part.dart';
import 'package:sama/Model/Post.dart';

import 'Deputy.dart';

class Sender extends Equatable {
  int userId;
  String fullname;
  String lastname;
  int deputyId;
  int partId;
  int postId;
  String pathCover;
  Deputy deputy;
  Part part;
  Post post;

  Sender(
      {this.userId,
      this.fullname,
      this.lastname,
      this.deputyId,
      this.partId,
      this.postId,
      this.pathCover,
      this.deputy,
      this.part,
      this.post});

  Sender.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullname = json['fullname'];
    lastname = json['lastname'];
    deputyId = json['deputy_id'];
    partId = json['part_id'];
    postId = json['post_id'];
    pathCover = json['pathCover'] != null ? json['pathCover'] : "";
    deputy =
        json['deputy'] != null ? new Deputy.fromJson(json['deputy']) : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['lastname'] = this.lastname;
    data['deputy_id'] = this.deputyId;
    data['part_id'] = this.partId;
    data['post_id'] = this.postId;
    data['pathCover'] = this.pathCover;
    if (this.deputy != null) {
      data['deputy'] = this.deputy.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        userId,
        fullname,
        lastname,
        deputyId,
        partId,
        postId,
        pathCover,
        deputy,
        part,
        post
      ];
}
