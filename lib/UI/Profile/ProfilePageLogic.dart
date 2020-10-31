import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:sama/SamaBase/Abstracts/DisposeAbstract.dart';

import 'ProfilePageValidator.dart';

class ProfilePageLogic extends Object
    with ProfilePageValidator
    implements Dispose {
  final _oldPassController = BehaviorSubject<String>();
  final _newPassController = BehaviorSubject<String>();
  final _confirmNewPassController = BehaviorSubject<String>();

  Function(String) get oldPassChange => _oldPassController.sink.add;
  Function(String) get newPassChange => _newPassController.sink.add;
  Function(String) get confirmNewPassChange =>
      _confirmNewPassController.sink.add;

  Stream<String> get oldPass =>
      _oldPassController.stream.transform(oldPassValidator);
  Stream<String> get newPass =>
      _newPassController.stream.transform(newPassValidator);
  Stream<String> get confirmNewPass =>
      _confirmNewPassController.stream.transform(confirmNewPassValidator);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(newPass, confirmNewPass, (e, p) => true);

  @override
  void dispose() {
    _oldPassController?.close();
    _newPassController?.close();
    _confirmNewPassController?.close();
  }
}
