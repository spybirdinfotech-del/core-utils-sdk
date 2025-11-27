import 'package:smartui_components/permission_services/permission_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

typedef PermissionCallback = void Function(
    bool isGranted,
    String message, {
    Position? location,
    });

typedef CustomDialogBuilder = Widget Function(
    BuildContext context,
    Future<void> Function() openSettings,
    Future<void> Function() retry,
    );

class PermissionHandlerService {
  static final PermissionCubit _cubit = PermissionCubit();

  static Future<void> handle({
    required Permission permission,
    required PermissionCallback onResult,
    BuildContext? context,
    CustomDialogBuilder? customDialogBuilder,
  }) async {
    await _cubit.requestPermission(
      permission,
      onResult,
      context: context,
      customDialogBuilder: customDialogBuilder,
    );
  }
}
