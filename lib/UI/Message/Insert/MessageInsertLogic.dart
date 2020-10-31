import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:sama/SamaBase/Abstracts/DisposeAbstract.dart';

import 'MessageInsertValidator.dart';

class MessageInsertLogic extends Object
    with MessageInsertValidator
    implements Dispose {
  final _titleController = BehaviorSubject<String>();
  final _textController = BehaviorSubject<String>();
  // final _listUserController = BehaviorSubject<List<User>>();

  Function(String) get titleChange => _titleController.sink.add;
  Function(String) get textChange => _textController.sink.add;
  // Function(User) get listUserChange => _listUserController.skip.call;

  Stream<String> get title => _titleController.stream.transform(titleValidator);
  Stream<String> get text => _textController.stream.transform(textValidator);
  // Stream<List<User>> get user => _listUserController.stream.transform(userValidator);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(title, text, (e, p) => true);

  @override
  void dispose() {
    _titleController?.close();
    _textController?.close();
  }
}
