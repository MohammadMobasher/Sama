import 'dart:async';

mixin ProfilePageValidator {
  var oldPassValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (oldPass, snik) {
    // if (oldPass.length > 6) {
    //   snik.add(oldPass);
    // } else {
    //   snik.addError("طول کارکتر‌ها نباید کمتر از 6 باشد");
    // }
  });

  var newPassValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (newPass, snik) {
    if (newPass.length > 6) {
      snik.add(newPass);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 6 باشد");
    }
  });

  var confirmNewPassValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (confirmNewPass, snik) {
    if (confirmNewPass.length > 6) {
      snik.add(confirmNewPass);
    } else {
      snik.addError("طول کارکتر‌ها نباید کمتر از 6 باشد");
    }
  });
}
