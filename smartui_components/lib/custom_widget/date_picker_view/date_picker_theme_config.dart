import 'package:smartui_components/custom_widget/date_picker_view/custom_date_picker_theme.dart';

class DatePickerThemeConfig {
  static CustomDatePickerTheme theme = const CustomDatePickerTheme();

  /// app in set global theme
  static void setTheme(CustomDatePickerTheme newTheme) {
    theme = newTheme;
  }
}
