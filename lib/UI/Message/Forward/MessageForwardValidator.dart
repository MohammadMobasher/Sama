import 'dart:async';

mixin MessageForwardValidator {
  var titleValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, snik) {
    if (title.length > 2) {
      snik.add(title);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 6 باشد");
    }
  });

  var textValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (text, snik) {
    if (text.length > 2) {
      snik.add(text);
    } else {
      snik.addError("محمد کارکتر‌ها نباید کمتر از 6 باشد");
    }
  });
}
