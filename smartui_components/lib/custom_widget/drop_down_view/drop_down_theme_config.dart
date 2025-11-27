import 'package:smartui_components/custom_widget/drop_down_view/custom_drop_down_theme.dart';

class DropDownThemeConfig {
  static CustomDropDownTheme theme = const CustomDropDownTheme();

  /// app in set global theme
  static void setTheme(CustomDropDownTheme newTheme) {
    theme = newTheme;
  }
}
