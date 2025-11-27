import 'package:flutter/cupertino.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? letterSpacing;
  final double? height;
  final List<Shadow>? shadows;
  final FontStyle? fontStyle;

  const CustomTextWidget(
    this.text,
    this.fontSize,
    this.color, {
    this.fontFamily,
    this.textAlign,
    this.textDecoration,
    this.overflow,
    this.fontWeight,
    this.maxLines,
    this.letterSpacing = 0.44,
    this.height = 1,
    this.shadows,
    this.fontStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      style: TextStyle(
        overflow: overflow ?? TextOverflow.clip,
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: color,
        height: height,
        letterSpacing: letterSpacing,
        shadows: shadows,
        fontStyle: fontStyle,
      ),
    );
  }
}
