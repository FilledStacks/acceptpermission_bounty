import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

import '../constants/app_strings.dart';

class NativeControlService {
  Future<String> acceptNativePermissionDialog() async {
    final completer = Completer<String>();

    // TASK: Add code here to accept the native permission dialog

    // The requirements are:
    //
    // 1. Ability to accept permissions

    // 2. Ability to deny permissions
    await Permission.location.request();
    var status = await Permission.location.status;
    if (status.isGranted || status.isLimited) {
      completer.complete(ksAcceptPermission);
    } else {
      completer.complete(ksNoAction);
    }

    return completer.future;
  }
}
