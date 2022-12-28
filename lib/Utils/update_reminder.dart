// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:new_version/new_version.dart';
//
// import '../Provders/login_control.dart';
//
// timerFunctionForUpdateReminder(BuildContext context) {
//   newVersions(context);
//   Timer.periodic(Duration(minutes: 10), (timer) {
//     timer = timer;
//     if (controlSignIn.canSendAnotherUpdateMessage) {
//       newVersions(context);
//       controlSignIn.controlSendAnotherUpdateMesaage(false);
//
//       print('coming from the timer');
//     }
//   });
// }
//
// ControlSignIn controlSignIn = ControlSignIn();
// newVersions(BuildContext context) async {
//   final newVersion = NewVersion();
//
//   final status = await newVersion.getVersionStatus();
//
//   print('can update: ${status?.canUpdate}');
//   print('local version ${status?.localVersion}');
//   print('store version ${status?.storeVersion}');
//
//   print(status?.storeVersion);
//   print(status?.appStoreLink);
//   if (status!.localVersion != status.storeVersion) {
//     newVersion.showUpdateDialog(
//         context: context,
//         versionStatus: status,
//         dialogTitle: 'Update Available',
//         dialogText:
//             'You can now update this app from ${status.localVersion} to ${status.storeVersion}',
//         updateButtonText: 'Update',
//         dismissButtonText: 'Dismiss',
//         dismissAction: () => {
//               controlSignIn.controlSendAnotherUpdateMesaage(true),
//               Navigator.pop(context)
//             });
//   }
//
//   // if (status!.localVersion != status.storeVersion) {
//   //   newVersion.launchAppStore(status.appStoreLink.toString());
//   // }
//
//   // var localVersion = status?.localVersion; // (1.2.1)
//   // var storeVersion = status?.storeVersion; // (1.2.3)
//   // var appStroeLink = status?.appStoreLink;
// }
