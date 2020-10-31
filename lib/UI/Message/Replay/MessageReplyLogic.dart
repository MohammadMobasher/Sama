import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:sama/SamaBase/Abstracts/DisposeAbstract.dart';
import 'MessageReplyValidator.dart';

class MessageReplyLogic extends Object
    with MessageReplyValidator
    implements Dispose {
  final _titleController = BehaviorSubject<String>();
  final _textController = BehaviorSubject<String>();

  Function(String) get titleChange => _titleController.sink.add;
  Function(String) get textChange => _textController.sink.add;

  Stream<String> get title => _titleController.stream.transform(titleValidator);
  Stream<String> get text => _textController.stream.transform(textValidator);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(title, text, (e, p) => true);

  @override
  void dispose() {
    _titleController?.close();
    _textController?.close();
  }
}
