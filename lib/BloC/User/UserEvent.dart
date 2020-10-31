import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserEventChangePassword extends UserEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  const UserEventChangePassword(
      {@required this.currentPassword,
      @required this.newPassword,
      @required this.confirmNewPassword});

  @override
  List<Object> get props => [currentPassword, newPassword, confirmNewPassword];
}
