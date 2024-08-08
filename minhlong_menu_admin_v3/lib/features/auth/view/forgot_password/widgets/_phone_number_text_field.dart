part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordScreenState {
  Widget get _buildPhoneNumberTextField => SizedBox(
        width: 360,
        child: CommonTextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLines: 1,
          validator: (value) => AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ',
          labelText: 'Số điện thoại',
          prefixIcon: Icon(
            Icons.phone_android_outlined,
            color: context.bodyMedium!.color!.withOpacity(0.5),
          ),
        ),
      );
}
