import 'dart:io';

import 'package:example/constants/app_strings.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Accept Permission Test', () {
    late FlutterDriver driver;

    SerializableFinder _getFinderForKey(String key) {
      return find.byValueKey(key);
    }

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(printCommunication: true);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });
    test('Get platform information', () async {
      final vm = await driver.serviceClient.getVM();

      // Access the platform information
      final platform = vm.operatingSystem;

      print('Platform: $platform');

      // Perform assertions or further actions based on the platform
      // For example:
      if (platform!.toLowerCase().contains('android')) {
        // Handle Android
        print('Running on Android');
      } else if (platform.toLowerCase().contains('ios')) {
        // Handle iOS
        print('Running on iOS');
      } else {
        print('Unsupported platform');
      }
    });

    test('Accept permission should navigate to main View', () async {
      final permissionButtonFinder = _getFinderForKey('permission_button');
      final homeViewFinder = _getFinderForKey('home_view');

      await driver.waitFor(permissionButtonFinder);
      await driver.tap(permissionButtonFinder);
      // Determine platform from environment variable or test parameter
      final vm = await driver.serviceClient.getVM();
      // Access the platform information
      final platform = vm.operatingSystem;

      final result = await driver.requestData(
          ksAcceptPermission); //Not in Use but will be used in Route Screen  Logic

      // Accept permissions using adb (Android)
      if (platform!.toLowerCase().contains('android')) {
        await _grantAndroidPermission();
      }
      //Accept for iOS
      if (platform.toLowerCase().contains('ios')) {
        // Execute simctl command to grant permission (iOS)
        await Process.run('xcrun', [
          'simctl',
          'privacy',
          'location',
          'com.example.example',
          'grant'
        ]); // TODO: Add seprate logic for this bundle name
      }
      // TASK: If you need to add code here, you can replace the line above with
      // your permission accept code
      //TODO: YOUR Screen Test Logic Here
      await driver.waitFor(homeViewFinder,
          timeout: Duration(seconds: 3)); //TODO: increase the time
    });
  });
}

Future<void> _grantAndroidPermission() async {
  // Replace <package_name> and <permission> with actual values
  final packageName = "com.example.example"; // TODO: Add seprate locic for this
  final permission1 = "android.permission.ACCESS_FINE_LOCATION";
  final permission2 = "android.permission.ACCESS_COARSE_LOCATION";

  // Execute adb command to grant permission
  await Process.run('adb', ['shell', 'pm', 'grant', packageName, permission1]);
  await Process.run('adb', ['shell', 'pm', 'grant', packageName, permission2]);
}
