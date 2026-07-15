import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> checkCameraPermission() async {
    bool isGranted;
    if (Platform.isIOS) {
      isGranted = await Permission.camera.status.isGranted;
      if (!isGranted) {
        final permissionStatus = await Permission.camera.request();
        return permissionStatus == PermissionStatus.granted;
      }

      return isGranted;
    }

    final permissionStatus = await Permission.camera.request();
    return permissionStatus == PermissionStatus.granted;
  }

  static Future<PermissionStatus> _requestPhotoGalleryPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status;
    }

    final plugin = DeviceInfoPlugin();
    final androidInfo = await plugin.androidInfo;

    if (androidInfo.version.sdkInt <= 32) {
      final status = await Permission.storage.request();
      return status;
    } else {
      final status = await Permission.photos.request();
      return status;
    }
  }

  static Future<bool> checkPhotoGalleryPermission() async {
    bool isGranted;
    if (Platform.isIOS) {
      isGranted =
          await Permission.photos.status.isGranted ||
          await Permission.photos.status.isLimited;
      if (!isGranted) {
        final permissionStatus = await _requestPhotoGalleryPermission();

        return permissionStatus == PermissionStatus.granted;
      }

      return isGranted;
    }

    final plugin = DeviceInfoPlugin();
    final androidInfo = await plugin.androidInfo;

    isGranted = androidInfo.version.sdkInt <= 32
        ? await Permission.storage.status.isGranted
        : await Permission.photos.status.isGranted;
    if (!isGranted) {
      final permissionStatus = await _requestPhotoGalleryPermission();
      return permissionStatus == PermissionStatus.granted;
    }

    return isGranted;
  }

  static Future<bool> checkNotificationPermission() async {
    bool isGranted;
    if (Platform.isIOS) {
      isGranted = await Permission.notification.status.isGranted;
      if (!isGranted) {
        final permissionStatus = await Permission.notification.request();
        return permissionStatus == PermissionStatus.granted;
      }

      return isGranted;
    }

    final permissionStatus = await Permission.notification.request();
    return permissionStatus == PermissionStatus.granted;
  }
}
