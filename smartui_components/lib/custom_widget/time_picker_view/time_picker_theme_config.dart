import 'package:smartui_components/custom_widget/time_picker_view/custom_time_picker_theme.dart';

class TimePickerThemeConfig {
  static CustomTimePickerTheme theme = CustomTimePickerTheme();

  /// app in set global theme
  static void setTheme(CustomTimePickerTheme newTheme) {
    theme = newTheme;
  }
}
