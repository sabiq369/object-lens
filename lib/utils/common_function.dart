import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionDialog() {
  Get.defaultDialog(
    title: 'Permission Required',
    middleText:
        'Camera and Microphone permission is denied. Please go to settings to enable it.',
    textConfirm: 'Open Settings',
    onConfirm: () {
      Get.back();
      openAppSettings(); // Opens the app settings page
    },
    textCancel: 'Cancel',
    titleStyle: TextStyle(
      fontFamily: 'Times New Roman',
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.black,
    ),
    middleTextStyle: TextStyle(
      fontFamily: 'Times New Roman',
      fontSize: 15.0,
      color: Colors.black,
    ),
    buttonColor: Colors.black,
    onCancel: () {
      Get.back();
    },
  );
}
