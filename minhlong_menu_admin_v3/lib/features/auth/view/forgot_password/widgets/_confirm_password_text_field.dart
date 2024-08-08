part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordScreenState {
  Widget get _buildComfirmPasswordField => ValueListenableBuilder(
        valueListenable: _isShowConfirmPassword,
        builder: (context, value, child) => SizedBox(
          width: 360,
          child: CommonTextField(
            style: context.bodyMedium,
            controller: _confirmPasswordController,
            onChanged: (p0) {},
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            validator: (value) {
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Xác nhận mật khẩu không khớp';
              }
              return AppRes.validatePassword(value)
                  ? null
                  : 'mật khẩu không hợp lệ';
            },
            labelText: 'Xác nhận mật khẩu',
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _isShowConfirmPassword.value = !_isShowConfirmPassword.value;
              },
              child: Icon(
                value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: context.bodyMedium!.color!.withOpacity(0.5),
              ),
            ),
          ),
        ),
      );
}
