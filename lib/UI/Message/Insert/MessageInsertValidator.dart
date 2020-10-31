import 'dart:async';

mixin MessageInsertValidator {
  var titleValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, snik) {
    if (title.length >= 3) {
      snik.add(title);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 3 باشد");
    }
  });

  var textValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (text, snik) {
    if (text.length >= 1) {
      snik.add(text);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 1 باشد");
    }
  });
}
