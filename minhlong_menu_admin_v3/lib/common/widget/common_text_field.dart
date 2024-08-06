import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../core/app_const.dart';

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
      this.hintStyle,
      this.labelStyle});
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
  final TextStyle? labelStyle;

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
        style: style ?? context.bodyMedium,
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
                borderSide: BorderSide(color: context.colorScheme.error)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: BorderSide(color: context.colorScheme.error)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide()),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: const BorderSide(color: Colors.white54)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                borderSide: BorderSide(color: context.colorScheme.primary)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorText: errorText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            filled: filled ?? false,
            hintText: hintText,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorStyle: context.bodyMedium!.copyWith(color: Colors.red),
            hintStyle: hintStyle ??
                context.bodyMedium!.copyWith(
                    color: context.bodyMedium!.color!.withOpacity(0.5)),
            labelStyle: labelStyle ?? context.bodyMedium),
        onChanged: onChanged);
  }
}
