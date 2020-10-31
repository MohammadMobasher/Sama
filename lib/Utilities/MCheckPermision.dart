import 'package:permission_handler/permission_handler.dart';

class MCheckPermision {
  static Future<bool> requestPermissions(Permission permission) async {
    var status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      var result = await permission.request();
      if (result.isGranted) {
        return true;
      }
    } else if (status.isUndetermined) {
      var result = await permission.request();
      if (result.isGranted) {
        return true;
      }
    }
    return false;
  }
}
