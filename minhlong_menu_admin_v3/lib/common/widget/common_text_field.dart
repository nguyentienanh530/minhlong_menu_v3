import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.errorText,
      this.onChanged,
      this.hintText,
      this.keyboardType,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.controller,
      this.prefixIcon,
      this.labelText,
      this.maxLines,
      this.onFieldSubmitted,
      this.filled,
      this.enabled,
      this.inputFormatters,
      this.style,
      this.focusNode,
      this.readOnly,
      this.hintStyle});
  final TextStyle? hintStyle;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final String? labelText;
  final Function(String)? onFieldSubmitted;
  final bool? filled;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final FocusNode? focusNode;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller!,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textAlignVertical: TextAlignVertical.center,
        key: key,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        style: style ?? kBodyStyle,
        textAlign: TextAlign.start,
        keyboardType: keyboardType ?? TextInputType.text,
        autocorrect: false,
        autofocus: false,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        enabled: enabled ?? true,
        obscureText: obscureText ?? false,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
            // isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: AppColors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: AppColors.red)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: AppColors.lavender)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: AppColors.lavender)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: AppColors.lavender)),
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16).r,
            filled: filled ?? false,
            hintText: hintText,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorStyle: kBodyStyle.copyWith(color: AppColors.red),
            hintStyle: hintStyle ??
                kBodyStyle.copyWith(color: AppColors.secondTextColor),
            labelStyle: kBodyWhiteStyle.copyWith(color: AppColors.white)),
        onChanged: onChanged);
  }
}
