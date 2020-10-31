import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/BloC/Login/LoginEvent.dart';
import 'package:sama/BloC/Login/LoginState.dart';
import 'package:sama/Model/DTO/LoginDTO.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Repository/LoginRepository.dart';
import 'package:sama/Repository/UserRepository.dart';
import 'package:sama/Utilities/MPref.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBLoc({this.loginRepository}) : assert(loginRepository != null);

  @override
  LoginState get initialState => LoginStatePreInit();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    //final prefs = await SharedPreferences.getInstance();
    if (event is LoginEventPreInit) {
      final accessToken = MPref.getString('AccessToken');
      //final userInfo = prefs.getStringList('userInfo') ?? [];
      if (accessToken != null && accessToken.length > 0) {
        yield LoginStateSuccess();
      } else {
        yield LoginStateInit();
      }
    } else if (event is LoginEventInit) {
      final accessToken = MPref.getString('AccessToken');
      // final userInfo = prefs.getStringList('userInfo') ?? [];
      if (accessToken != null && accessToken.length > 0) {
        yield LoginStateSuccess();
      } else {
        yield LoginStateInit();
      }
    } else if (event is LoginEventLogOut) {
      MPref.clear();
      yield LoginStateInit();
    } else if (event is LoginEventSubmitPress) {
      yield LoginStateInProgress();
      Login result;
      try {
        result = await loginRepository.login(event.userName, event.password);
      } catch (e) {
        print(e);
      }
      if (result != null) {
        if (result.accessToken != null) {
          MPref.setString('AccessToken', result.accessToken);
          MPref.setString(
              'FullName', result.user.fullname + " " + result.user.lastname);
          MPref.setString('FirstName', result.user.fullname);
          MPref.setString('LastName', result.user.lastname);
          MPref.setString('Image', result.user.pathCover);
          MPref.setString('UserName', result.user.username);
          MPref.setString('PostTitle', result.user.post.title);

          yield LoginStateSuccess();
        } else {
          yield LoginStateFailure(
              error: "نام کاربری و یا رمز عبور صحیح نمی‌باشد");
        }
      } else {
        yield LoginStateFailure(
            error: "نام کاربری و یا رمز عبور صحیح نمی‌باشد");
      }
    } else if (event is LoginEventChangePass) {
      //yield LoginStateInProgress();
      // var result = await loginRepository.changePassword(
      //     event.currentPassword, event.newPassword, event.confirmNewPassword);
    }
  }
}
