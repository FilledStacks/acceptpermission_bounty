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

    test('Accept permission should navigate to main View', () async {
      final permissionButtonFinder = _getFinderForKey('permission_button');
      final homeViewFinder = _getFinderForKey('home_view');

      await driver.waitFor(permissionButtonFinder);
      await driver.tap(permissionButtonFinder);

      final result = await driver.requestData(ksAcceptPermission);

      await driver.waitFor(homeViewFinder, timeout: Duration(seconds: 3));
    });
  });
}
