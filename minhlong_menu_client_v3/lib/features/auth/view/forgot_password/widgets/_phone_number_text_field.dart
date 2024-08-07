part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordViewState {
  Widget get _buildPhoneField => CommonTextField(
        controller: _phoneController,
        onChanged: (p0) {},
        keyboardType: TextInputType.phone,
        maxLines: 1,
        validator: (value) {
          return AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ';
        },
        labelText: 'Số điện thoại',
        labelStyle: context.bodyMedium,
        style: context.bodyMedium,
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: context.colorScheme.primary.withOpacity(0.9),
        ),
      );
}
