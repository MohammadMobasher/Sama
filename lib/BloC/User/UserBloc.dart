import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sama/Model/User.dart';
import 'package:sama/Repository/UserRepository.dart';

import 'UserEvent.dart';
import 'UserState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({this.userRepository}) : assert(userRepository != null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    try {
      if (event is UserEventChangePassword) {
        yield UserStateInProgress();
        var result = await userRepository.changePassword(
          event.currentPassword, event.newPassword, event.confirmNewPassword);
        yield UserStateProgressComplete(user: new User());
      }
    } catch (e) {
      print(e);
      yield UserStateError();
    }
  }

  @override
  UserState get initialState => UserStateInit();
}
