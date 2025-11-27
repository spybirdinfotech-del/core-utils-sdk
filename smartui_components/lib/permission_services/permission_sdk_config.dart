import 'package:smartui_components/permission_services/permission_theme.dart';

class PermissionSDKConfig {
  static PermissionTheme theme = const PermissionTheme();

  /// app in set global permission theme
  static void setTheme(PermissionTheme newTheme) {
    theme = newTheme;
  }
}
