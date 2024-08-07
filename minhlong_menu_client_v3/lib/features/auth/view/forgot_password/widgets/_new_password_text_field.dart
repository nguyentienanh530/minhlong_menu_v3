part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordViewState {
  Widget get _buildPasswordField => ListenableBuilder(
        listenable: _isShowPassword,
        builder: (context, _) {
          return CommonTextField(
            maxLines: 1,
            controller: _passwordController,
            onFieldSubmitted: (p0) {},
            labelText: AppString.newPassword,
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            onChanged: (value) {},
            obscureText: !_isShowPassword.value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.colorScheme.primary.withOpacity(0.8),
            ),
            suffixIcon: GestureDetector(
              onTap: () => _isShowPassword.value = !_isShowPassword.value,
              child: Icon(
                !_isShowPassword.value
                    ? Icons.visibility_off
                    : Icons.remove_red_eye,
                color: context.bodyMedium!.color!.withOpacity(0.5),
              ),
            ),
          );
        },
      );
}
