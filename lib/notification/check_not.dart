import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'one_signal_controler.dart';

Future<void> checkNotification() async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  late final PermissionStatus statusess;

  if (androidInfo.version.sdkInt == 33) {
    statusess = await Permission.notification.request();
    debugPrint('statuse : $statusess');
    OneSignalControler.inite();
  } else {
    OneSignalControler.inite();
  }
}
