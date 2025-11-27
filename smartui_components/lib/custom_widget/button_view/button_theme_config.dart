import 'package:smartui_components/custom_widget/button_view/custom_button_theme.dart';

class ButtonThemeConfig {
  static CustomButtonTheme theme = const CustomButtonTheme();

  /// app in set global theme
  static void setTheme(CustomButtonTheme newTheme) {
    theme = newTheme;
  }
}
