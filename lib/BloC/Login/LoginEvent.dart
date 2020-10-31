import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEventPreInit extends LoginEvent {
  @override
  List<Object> get props => null;
}

class LoginEventInit extends LoginEvent {
  @override
  List<Object> get props => null;
}

class LoginEventSubmitPress extends LoginEvent {
  final String userName;
  final String password;

  const LoginEventSubmitPress(
      {@required this.userName, @required this.password});

  @override
  List<Object> get props => [userName, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $userName, password: $password }';
}

class LoginEventChangePass extends LoginEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  LoginEventChangePass(
      {@required this.currentPassword,
      @required this.newPassword,
      @required this.confirmNewPassword});

  @override
  List<Object> get props => [currentPassword, newPassword, confirmNewPassword];
}

class LoginEventLogOut extends LoginEvent {
  @override
  List<Object> get props => null;
}
