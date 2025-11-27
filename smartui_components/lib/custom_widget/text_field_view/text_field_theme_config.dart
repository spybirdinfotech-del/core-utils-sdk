import 'package:smartui_components/custom_widget/text_field_view/custom_text_field_theme.dart';

class TextFieldThemeConfig {
  static CustomTextFieldTheme theme = const CustomTextFieldTheme();

  /// app in set global theme
  static void setTheme(CustomTextFieldTheme newTheme) {
    theme = newTheme;
  }
}
