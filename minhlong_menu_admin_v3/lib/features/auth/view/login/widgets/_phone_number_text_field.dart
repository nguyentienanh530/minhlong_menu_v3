part of '../screen/login_screen.dart';

extension on _LoginScreenState {
  Widget get _buildPhoneNumberTextField => CommonTextField(
        controller: _phoneCtrl,
        keyboardType: TextInputType.phone,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        labelText: AppString.phoneNumber,
        validator: (value) {
          return AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ';
        },
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.5),
        ),
        style: context.bodyMedium!.copyWith(color: context.bodyMedium!.color),
        onFieldSubmitted: (p0) => _handleLoginSubmited(),
      );
}
