import 'package:smartui_components/custom_widget/appbar_view/custom_app_bar_theme.dart';

class AppBarThemeConfig {
  static CustomAppBarTheme theme = const CustomAppBarTheme();

  /// app in set global theme
  static void setTheme(CustomAppBarTheme newTheme) {
    theme = newTheme;
  }
}
