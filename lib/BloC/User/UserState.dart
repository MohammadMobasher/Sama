import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sama/Model/User.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateInit extends UserState {}

class UserStateInProgress extends UserState {}

class UserStateProgressComplete extends UserState {
  final User user;

  UserStateProgressComplete({@required this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class UserStateError extends UserState {}
