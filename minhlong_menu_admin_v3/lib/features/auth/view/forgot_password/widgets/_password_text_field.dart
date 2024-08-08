part of '../screens/forgot_password_screen.dart';

extension on _ForgotPasswordScreenState {
  Widget get _buildPasswordTextField => ValueListenableBuilder(
        valueListenable: _isShowPassword,
        builder: (context, value, child) => SizedBox(
          width: 360,
          child: CommonTextField(
            style: context.bodyMedium,
            controller: _passwordController,
            onChanged: (p0) {},
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            validator: (value) {
              return AppRes.validatePassword(value)
                  ? null
                  : 'mật khẩu không hợp lệ';
            },
            labelText: 'Mật khẩu mới',
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
            obscureText: !value,
            suffixIcon: GestureDetector(
              onTap: () {
                _isShowPassword.value = !_isShowPassword.value;
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
