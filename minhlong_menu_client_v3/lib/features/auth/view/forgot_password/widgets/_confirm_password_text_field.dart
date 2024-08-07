part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordViewState {
  Widget get _buildConfirmPasswordField => ListenableBuilder(
        listenable: _isShowConfirmPassword,
        builder: (context, _) {
          return CommonTextField(
            maxLines: 1,
            controller: _confirmPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: AppString.confirmPassword,
            validator: (value) {
              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Xác nhận mật khẩu không khớp';
              }
              return AppRes.validatePassword(value)
                  ? null
                  : 'mật khẩu không hợp lệ';
            },
            onChanged: (value) {},
            obscureText: !_isShowConfirmPassword.value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.colorScheme.primary.withOpacity(0.8),
            ),
            suffixIcon: GestureDetector(
              onTap: () =>
                  _isShowConfirmPassword.value = !_isShowConfirmPassword.value,
              child: Icon(
                !_isShowConfirmPassword.value
                    ? Icons.visibility_off
                    : Icons.remove_red_eye,
                color: context.bodyMedium!.color!.withOpacity(0.5),
              ),
            ),
          );
        },
      );
}
