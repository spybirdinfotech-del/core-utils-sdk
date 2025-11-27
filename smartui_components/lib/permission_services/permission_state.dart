import 'package:geolocator/geolocator.dart';

abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionRequesting extends PermissionState {}

class PermissionGrantedState extends PermissionState {
  final Position? location;
  PermissionGrantedState({this.location});
}

class PermissionDeniedState extends PermissionState {
  final String message;
  PermissionDeniedState(this.message);
}

class PermissionPermanentlyDeniedState extends PermissionState {}
