import 'dart:async';

mixin LoginPageValidator {
  var userNameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, snik) {
    if (userName.length > 5) {
      snik.add(userName);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 5 باشد");
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, snik) {
    if (password.length > 5) {
      snik.add(password);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 5 باشد");
    }
  });
}
