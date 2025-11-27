import 'package:smartui_components/snackbar_handle/snackbar_theme.dart';

class SnackbarThemeConfig {
  static SnackbarTheme theme = const SnackbarTheme();

  /// App will call this once in main()
  static void setTheme(SnackbarTheme newTheme) {
    theme = newTheme;
  }
}
