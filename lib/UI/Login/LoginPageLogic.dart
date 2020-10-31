import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sama/SamaBase/Abstracts/DisposeAbstract.dart';
import 'package:sama/UI/Login/LoginPageValidator.dart';

class LoginPageLogic extends Object with LoginPageValidator implements Dispose {
  final _userNameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get userNameChange => _userNameController.sink.add;
  Function(String) get passwordChange => _passwordController.sink.add;

  Stream<String> get userName =>
      _userNameController.stream.transform(userNameValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<bool> get submitCheck =>
      Rx.combineLatest2(userName, password, (e, p) => true);

  @override
  void dispose() {
    _userNameController?.close();
    _passwordController?.close();
  }
}
