import 'package:example/constants/app_strings.dart';
import 'package:example/services/native_control_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:get/get.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

Future<void> main() async {
  setupLocator();

  enableFlutterDriverExtension(handler: (message) {
    final naviteControlService = locator<NativeControlService>();

    if (message == ksAcceptPermission) {
      return naviteControlService.acceptNativePermissionDialog();
    }

    return Future.value(ksNoAction);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: Routes.mediaPermissionsView,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
