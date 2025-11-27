import 'package:smartui_components/permission_services/permission_sdk_config.dart';
import 'package:smartui_components/permission_services/permission_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../smartui_components.dart';
import '../remote/util/string_file.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  Future<void> requestPermission(
    Permission permission,
    PermissionCallback onResult, {
    BuildContext? context,
    CustomDialogBuilder? customDialogBuilder,
  }) async {
    emit(PermissionRequesting());

    final status = await permission.status;

    if (status.isGranted) {
      await _onGranted(permission, onResult);
      return;
    }

    final newStatus = await permission.request();

    if (newStatus.isGranted) {
      await _onGranted(permission, onResult);
    } else if (newStatus.isDenied) {
      emit(PermissionDeniedState(StringFile.permissionDenied));
      onResult(false, StringFile.permissionDenied);
    } else if (newStatus.isPermanentlyDenied) {
      emit(PermissionPermanentlyDeniedState());

      if (context != null) {
        if (customDialogBuilder != null) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => customDialogBuilder(
              context,
              openAppSettings,
              () => requestPermission(permission, onResult, context: context, customDialogBuilder: customDialogBuilder),
            ),
          );
        } else {
          await _showPermissionDialog(context, permission, onResult);
        }
      } else {
        await openAppSettings();
      }
    } else {
      emit(PermissionDeniedState('Permission status: $newStatus'));
      onResult(false, 'Permission status: $newStatus');
    }
  }

  Future<void> _onGranted(Permission permission, PermissionCallback onResult) async {
    if (_isLocationPermission(permission)) {
      try {
        final location = await _getCurrentLocation();
        emit(PermissionGrantedState(location: location));
        onResult(true, 'Permission granted', location: location);
      } catch (e) {
        emit(PermissionGrantedState());
        onResult(true, 'Permission granted (location error: $e)');
      }
    } else {
      emit(PermissionGrantedState());
      onResult(true, StringFile.permissionGranted);
    }
  }

  bool _isLocationPermission(Permission permission) =>
      permission == Permission.location ||
      permission == Permission.locationAlways ||
      permission == Permission.locationWhenInUse;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission geoPermission = await Geolocator.checkPermission();
    if (geoPermission == LocationPermission.denied) {
      geoPermission = await Geolocator.requestPermission();
      if (geoPermission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (geoPermission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _showPermissionDialog(BuildContext context, Permission permission, PermissionCallback onResult) async {
    final theme = PermissionSDKConfig.theme;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        contentPadding: EdgeInsets.fromLTRB(15,0,15,10),
        backgroundColor: Colors.white,
        title: Text(
          StringFile.permissionRequired,
          style: theme.titleTextStyle ?? TextStyle(color: theme.titleTextColor, fontWeight: FontWeight.bold),
        ),
        content: Text(
          '${permission.toString().split('.').last} ${StringFile.permissionRequiredContent}',
          style: theme.contentTextStyle ?? TextStyle(color: theme.contentTextColor, fontWeight: FontWeight.normal),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
              await Future.delayed(const Duration(seconds: 1));
              final newStatus = await permission.status;
              if (newStatus.isGranted) {
                await _onGranted(permission, onResult);
              } else {
                emit(PermissionDeniedState(StringFile.permissionDenied));
                onResult(false, StringFile.permissionDenied);
              }
            },
            child: Text(
              StringFile.openSetting,
              style: theme.buttonTextStyle ?? TextStyle(color: theme.buttonTextColor, fontWeight: FontWeight.normal),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final status = await permission.request();
              if (status.isGranted) {
                await _onGranted(permission, onResult);
              } else {
                emit(PermissionDeniedState(StringFile.permissionStillDenied));
                onResult(false, StringFile.permissionStillDenied);
              }
            },
            child: Text(
              StringFile.tryAgain,
              style: theme.buttonTextStyle ?? TextStyle(color: theme.buttonTextColor, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
