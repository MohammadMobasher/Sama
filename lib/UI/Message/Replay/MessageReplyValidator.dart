import 'dart:async';

import 'package:sama/Model/User.dart';

mixin MessageReplyValidator {
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
    // if (text.length > 0) {
      snik.add(text);
    // }
  });

  // var userValidator = StreamTransformer<List<User>, String>.fromHandlers(
  //     handleData: (text, snik) {
  //   if (text.length > 0) {
  //     // snik.add(text);
  //   } else {
  //     snik.addError("محمد کارکتر‌ها نباید کمتر از 6 باشد");
  //   }
  // });
}
