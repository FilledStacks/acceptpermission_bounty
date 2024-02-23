# Permission Accept Bounty

The price for this bounty is $250 and the requirements are as follows. 

[Bounty hosted by Ticket Stacker](https://ticketstacker.substack.com/)

### Requirement

When running a Flutter Driver Test, and a permission dialog is shown, we should be able to accept it automatically using code. 

This should be possible for Android and for iOS.

### Technical Overview

In `main_test.dart` is where you'll find the driver test. 

It taps on the button, then calls `requestData` which goes to the `main.dart` file, and executes the function `acceptNativePermissionDialog` on the `NativeControlService`. 

In this function is where you can add the code to accept permissions, you can also add underneat the test code on line 30 in `main_test.dart`

### What Is Allowed

- This will be run on Android emulators and iOS Simulators
- You can use `adb` directly from the dart code if you need to
- You can use any of the `xcode` command-line tools

### Run the code

1. Run `flutter pub get`
2. Run `flutter drive` and make sure you have an emulator/simulator open