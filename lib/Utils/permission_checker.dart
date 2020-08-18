import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  PermissionStatus permissionStatus = PermissionStatus.undetermined;
  Permission permission = Permission.storage;

  Future listenForPermissionStatus() async {
    final status = await permission.status;
    permissionStatus = status;
  }

  Future<void> requestPermission() async {
    final status = await permission.request();
    permissionStatus = status;
  }

  Future<bool> checkPermission() async {
    await listenForPermissionStatus();

    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

final permision = PermissionChecker();
