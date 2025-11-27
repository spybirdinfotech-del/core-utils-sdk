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
  });

  @override
  Widget build(BuildContext context) {
    final theme = ButtonThemeConfig.theme;

    return SizedBox(
      width: width ?? theme.width ?? double.infinity,
      height: height ?? theme.height ?? 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.buttonColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? theme.borderRadius ?? BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onTap,
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
