import 'package:flutter/material.dart';
import '../button_view/button_theme_config.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Color? color;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final BoxShape? shape;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.color,
    this.textStyle,
    this.borderRadius,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.gradient,
    this.boxShadow,
    this.border,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ButtonThemeConfig.theme;

    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? theme.width ?? double.infinity,
        height: height ?? theme.height ?? 48,
        decoration: BoxDecoration(
          gradient: gradient ?? theme.gradient,
          color: color ?? theme.buttonColor ?? Theme.of(context).primaryColor,
          boxShadow: boxShadow ?? theme.boxShadow,
          border: border ?? theme.border,
          borderRadius: borderRadius ?? theme.borderRadius ?? BorderRadius.circular(10),
          shape: shape ?? theme.shape ?? BoxShape.rectangle
        ), //button gradient
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: textStyle ??
                  theme.buttonTextStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
