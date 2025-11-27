import 'package:smartui_components/custom_widget/appbar_view/app_bar_theme_config.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final void Function()? onTap;
  final bool closeIcon;
  final bool backIcon;
  final double? letterSpacing;
  final bool isAddItems;
  final bool isCenterTitle;
  final List<Widget>? actions;
  final double? elevation;

  const CustomAppbar({
    super.key,
    required this.title,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.onTap,
    this.closeIcon = false,
    this.backIcon = true,
    this.letterSpacing,
    this.isAddItems = false,
    this.isCenterTitle = true,
    this.actions,
    this.elevation = 0.0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {

    final theme = AppBarThemeConfig.theme;

    return AppBar(
      toolbarHeight: preferredSize.height,
      backgroundColor: theme.bgColor ?? Colors.white,
      surfaceTintColor: theme.surfaceTintColor ?? Colors.white,
      actions: actions,
      leading: backIcon
          ? Padding(
              padding: EdgeInsets.only(left: 10),
              child: backWidget(
                onTap: theme.backOnTap ?? onTap,
                Icon(theme.icon ?? Icons.arrow_back_ios, size: 17, color: Colors.black, weight: 5),
                context,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: isCenterTitle,
      elevation: theme.elevation ?? elevation,
      title: Text(
        title,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize ?? theme.fontSize ?? 15,
          color: textColor ?? theme.titleTextColor ?? Colors.black,
          fontWeight: fontWeight ?? theme.fontWeight ?? FontWeight.w600,
          fontFamily: fontFamily ?? theme.fontFamily,
          letterSpacing: letterSpacing ?? 0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget backWidget(Widget? child, BuildContext context, {Function()? onTap}) {
    return GestureDetector(onTap: onTap ?? () => Navigator.pop(context), child: child);
  }
}
