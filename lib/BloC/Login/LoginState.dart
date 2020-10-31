import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStatePreInit extends LoginState {}

class LoginStateInit extends LoginState {}

class LoginStateInProgress extends LoginState {}

class LoginStateFailure extends LoginState {
  final String error;

  const LoginStateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginStateSuccess extends LoginState {}
