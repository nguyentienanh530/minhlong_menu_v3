part of '../screen/login_screen.dart';

extension on _LoginScreenState {
  Widget _buildPassword() {
    var isShowPassword = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: isShowPassword,
      builder: (context, value, child) {
        return CommonTextField(
          maxLines: 1,
          style: context.bodyMedium!.copyWith(color: context.bodyMedium!.color),
          controller: _passwordCtrl,
          onFieldSubmitted: (p0) {
            _handleLoginSubmited();
          },
          labelStyle: context.bodyMedium,
          labelText: AppString.password,
          // labelText: AppString.password,
          validator: (password) => AppRes.validatePassword(password)
              ? null
              : 'Mật khẩu không hợp lệ',
          onChanged: (value) {
            // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            _passwordCtrl.text = value;
            RegExp(r'^(?=.*?[A-Z])').hasMatch(value)
                ? _oneUpperCase.value = true
                : _oneUpperCase.value = false;
            RegExp(r'^(?=.*?[a-z])').hasMatch(value)
                ? _oneLowerCase.value = true
                : _oneLowerCase.value = false;
            RegExp(r'^(?=.*?[a-z])').hasMatch(value)
                ? _oneLowerCase.value = true
                : _oneLowerCase.value = false;
            RegExp(r'^(?=.*?[0-9])').hasMatch(value)
                ? _oneNumericNumber.value = true
                : _oneNumericNumber.value = false;
            RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)
                ? _oneSpecialCharacter.value = true
                : _oneSpecialCharacter.value = false;
            value.length >= 8
                ? _least8Characters.value = true
                : _least8Characters.value = false;
          },
          obscureText: !value,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: context.bodyMedium!.color!.withOpacity(0.5),
          ),
          suffixIcon: GestureDetector(
            onTap: () => isShowPassword.value = !isShowPassword.value,
            child: Icon(
              !value ? Icons.visibility_off : Icons.remove_red_eye,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }
}
