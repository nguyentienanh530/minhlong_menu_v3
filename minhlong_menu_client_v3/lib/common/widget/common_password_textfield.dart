import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_const.dart';

class TextFieldPassword extends StatelessWidget {
  TextFieldPassword(
      {super.key,
      required this.valueListenable,
      required this.controller,
      required this.validator,
      this.labelText});
  final ValueNotifier<bool> valueListenable;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  String? labelText;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: context.bodyMedium,
            controller: controller,
            onFieldSubmitted: (p0) {},
            labelText: labelText,
            labelStyle: context.bodyMedium,
            validator: validator,
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.colorScheme.secondary.withOpacity(0.8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius / 3),
              borderSide: BorderSide(
                color: context.colorScheme.secondary,
              ),
            ),
            suffixIcon: GestureDetector(
                onTap: () => valueListenable.value = !valueListenable.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: context.bodyMedium!.color!.withOpacity(0.5))));
      },
    );
  }
}
