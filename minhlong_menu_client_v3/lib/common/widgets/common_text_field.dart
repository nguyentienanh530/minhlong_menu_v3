import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_const.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.errorText,
      required this.onChanged,
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
      this.focusedErrorBorder,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.filled,
      this.hintStyle,
      this.style,
      this.contentPadding,
      this.labelStyle});
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool? filled;
  final InputBorder? focusedErrorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final String? hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines;
  final String? labelText;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller!,
        validator: validator,
        // expands: true,
        onFieldSubmitted: onFieldSubmitted,
        textAlignVertical: TextAlignVertical.center,
        key: key,
        maxLines: maxLines,
        style: style ?? context.bodyMedium,
        textAlign: TextAlign.start,
        keyboardType: keyboardType ?? TextInputType.text,
        autocorrect: false,
        autofocus: false,
        obscureText: obscureText ?? false,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
            isDense: true,
            focusedErrorBorder: focusedErrorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldBorderRadius),
                    borderSide: BorderSide(color: context.colorScheme.outline)),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldBorderRadius),
                    borderSide: BorderSide(color: context.colorScheme.error)),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldBorderRadius),
                    borderSide: BorderSide(color: context.colorScheme.outline)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldBorderRadius),
                    borderSide: BorderSide(color: context.colorScheme.primary)),
            errorText: errorText,
            contentPadding:
                contentPadding ?? const EdgeInsets.all(defaultPadding),
            filled: filled ?? false,
            hintText: hintText,
            labelText: labelText,
            errorStyle:
                context.bodyMedium!.copyWith(color: context.colorScheme.error),
            hintStyle: hintStyle ?? context.bodyMedium,
            labelStyle: labelStyle ?? context.bodyMedium),
        onChanged: onChanged);
  }
}
