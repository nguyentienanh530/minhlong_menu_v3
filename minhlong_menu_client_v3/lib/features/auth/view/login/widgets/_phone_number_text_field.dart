part of '../screens/login_screen.dart';

extension _PhoneNumberTextField on _LoginScreenState {
  Widget get _phoneNumberTextField => CommonTextField(
      controller: _phoneCtrl,
      keyboardType: TextInputType.phone,
      labelText: AppString.phoneNumber,
      labelStyle: context.bodyMedium,
      style: context.bodyMedium,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius / 3),
        borderSide: BorderSide(color: context.colorScheme.primary),
      ),
      validator: (value) {
        return AppRes.validatePhoneNumber(value)
            ? null
            : 'Số điện thoại không hợp lệ';
      },
      prefixIcon: Icon(
        Icons.phone_android_outlined,
        color: context.colorScheme.primary.withOpacity(0.8),
      ),
      onFieldSubmitted: (p0) => _handleLoginSubmited(),
      onChanged: (value) {});
}
