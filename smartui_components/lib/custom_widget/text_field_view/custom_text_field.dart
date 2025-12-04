import 'package:smartui_components/custom_widget/text_field_view/text_field_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  CustomTextFormFieldWidget({
    super.key,
    required this.textController,
    this.textStyle,
    this.cursorHeight,
    this.textAlign = TextAlign.left,
    this.contentPadding,
    this.fillColor,
    this.filled,
    this.isDense = true,
    this.label,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disableborder,
    dynamic border,
    this.textColor,
    this.validation,
    this.keyboardType,
    this.inputFormatters,
    this.regexPattern,
    this.prefixTextValue,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.maxLines,
    this.textAlignVertical,
    this.maxLength,
    this.floatingLabelBehavior,
    this.prefixIconConstraints,
    this.obscureText = false,
    this.errorText = '',
    this.onFieldSubmitted,
    this.onTapOutside,
    this.focusNode,
    this.readOnly = false,
    this.errorStyle,
    this.cursorColor,
    this.textFieldBorderColor,
    this.labelStyle,
    this.labelText,
    this.maxLengthEnforcement = false,
    this.counterText,
    this.onTap,
    this.isPasswordField = false,
    this.suffixIconOnPressed,
    this.isRounded = false,
    this.suffixIconConstraints,
  }) : border = isRounded
           ? OutlineInputBorder(
               borderRadius: BorderRadius.circular(8),
               borderSide: BorderSide(color: Colors.grey, width: 1),
             )
           : border ?? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1));

  final TextEditingController textController;
  final TextStyle? textStyle;
  final double? cursorHeight;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final bool? filled;
  final bool? isDense;
  final Align? label;
  final dynamic enabledBorder;
  final dynamic focusedBorder;
  final dynamic errorBorder;
  final dynamic disableBorder;
  final dynamic border;
  final Color? textColor;
  final bool? validation;
  final TextInputType? keyboardType;
  final String? regexPattern;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixTextValue;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Null Function(dynamic value)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final int? maxLines;
  final TextAlignVertical? textAlignVertical;
  final int? maxLength;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BoxConstraints? prefixIconConstraints;
  final bool? obscureText;
  final String? errorText;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTapOutside;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextStyle? errorStyle;
  final Color? cursorColor;
  final Color? textFieldBorderColor;
  final bool maxLengthEnforcement;
  final String? counterText;
  final Future Function()? onTap;
  final bool isPasswordField;
  final Function()? suffixIconOnPressed;
  final bool isRounded;
  final BoxConstraints? suffixIconConstraints;

  List<TextInputFormatter> getFormatters() {
    // Priority 1 → Custom RegEx passed by user
    if (regexPattern != null && regexPattern!.isNotEmpty) {
      return [FilteringTextInputFormatter.allow(RegExp(regexPattern!))];
    }
    // Priority 2 → Auto formatter based on keyboardType
    else {
      if (keyboardType == TextInputType.text) {
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0900-\u097F\s]'))];
      } else if (keyboardType == TextInputType.phone) {
        return [FilteringTextInputFormatter.digitsOnly];
      } else if (keyboardType == TextInputType.emailAddress) {
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'))];
      } else if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
        return [FilteringTextInputFormatter.digitsOnly];
      } else if (keyboardType == TextInputType.text) {
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))];
      } else {
        return inputFormatters ?? [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TextFieldThemeConfig.theme;

    return TextFormField(
      cursorColor: cursorColor ?? theme.cursorColor,
      cursorHeight: cursorHeight ?? theme.cursorHeight,
      onFieldSubmitted: onFieldSubmitted,
      obscuringCharacter: '*',
      obscureText: obscureText!,
      textAlign: textAlign,
      controller: textController,
      focusNode: focusNode,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap: onTap,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,
      keyboardType: keyboardType,

      inputFormatters: getFormatters(),

      style:
          textStyle ?? theme.textStyle ??
          TextStyle(color: textColor ?? Colors.black, fontFamily: theme.fontFamily, fontSize: 16, letterSpacing: -0.28),

      textAlignVertical: textAlignVertical,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        errorMaxLines: 3,
        errorStyle: errorStyle ?? theme.errorStyle,
        counterStyle: TextStyle(color: Colors.black, fontFamily: theme.fontFamily, fontSize: 10),
        counterText: counterText ?? '',
        hintText: hintText,
        hintStyle: hintStyle ?? theme.hintStyle ?? TextStyle(color: Colors.grey, fontFamily: theme.fontFamily, fontSize: 16),
        labelText: labelText,
        labelStyle: labelStyle ?? theme.labelStyle ?? TextStyle(color: Colors.grey, fontSize: 16, fontFamily: theme.fontFamily),
        contentPadding: contentPadding ?? theme.contentPadding ?? (isRounded ? EdgeInsets.all(16) : EdgeInsets.only(bottom: 3)),
        fillColor: fillColor ?? theme.fillColor ?? Colors.white,
        filled: filled ?? theme.filled,
        isDense: isDense,
        label: label,
        errorText: errorText!.isEmpty ? null : errorText,
        errorBorder: errorBorder ?? theme.errorBorder,
        border: border ?? theme.border,
        enabledBorder: enabledBorder ?? theme.enableBorder ?? border,
        disabledBorder: disableBorder ?? theme.disableBorder,
        focusedBorder: isRounded
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              )
            : focusedBorder ?? theme.focusBorder ?? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1)),
        prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 30),
        prefix: prefix,
        prefixIcon: prefixTextValue != null && prefixTextValue != ''
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(prefixTextValue ?? '', style: TextStyle(color: Colors.black, fontSize: 16,)),
              )
            : prefixIcon,
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: (isPasswordField)
            ? IconButton(
                onPressed: () => suffixIconOnPressed!(),
                icon: Icon(obscureText! ? Icons.visibility_off_sharp : Icons.visibility, color: Colors.grey, size: 18),
              )
            : suffixIcon,
      ),
    );
  }
}
