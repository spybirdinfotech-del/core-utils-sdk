import 'package:flutter/material.dart';

class CustomDropDownTheme {
  final BorderRadiusGeometry? boxRadius;
  final Color? dropDownBoxColor;
  final Color? dropDownBoxBorderColor;
  final TextStyle? labelTextStyle;
  final TextStyle? menuTextStyle;
  final TextStyle? selectedTextStyle;
  final Color? menuItemBoxColor;
  final BorderRadiusGeometry? menuItemBoxRadius;
  final Color? menuItemBoxBorderColor;
  final Color? themeColor;
  final List<BoxShadow>? menuItemBoxShadow;
  final List<BoxShadow>? dropDownBoxShadow;


  const CustomDropDownTheme({
    this.boxRadius,
    this.dropDownBoxColor,
    this.dropDownBoxBorderColor,
    this.labelTextStyle,
    this.menuTextStyle,
    this.selectedTextStyle,
    this.menuItemBoxColor,
    this.menuItemBoxRadius,
    this.menuItemBoxBorderColor,
    this.themeColor,
    this.menuItemBoxShadow,
    this.dropDownBoxShadow,
  });
}
