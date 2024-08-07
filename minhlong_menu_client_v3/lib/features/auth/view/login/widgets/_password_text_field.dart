part of '../screens/login_screen.dart';

extension on _LoginScreenState {
  Widget _buildPasswordTextField() {
    var isShowPassword = ValueNotifier(false);
    return ValueListenableBuilder(
        valueListenable: isShowPassword,
        builder: (context, value, child) {
          return CommonTextField(
              maxLines: 1,
              controller: _passwordCtrl,
              onFieldSubmitted: (p0) {
                _handleLoginSubmited();
              },
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultBorderRadius / 3),
                borderSide: BorderSide(color: context.colorScheme.primary),
              ),
              obscureText: !value,
              style: context.bodyMedium,
              labelStyle: context.bodyMedium,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: context.colorScheme.primary.withOpacity(0.9),
              ),
              suffixIcon: GestureDetector(
                  onTap: () => isShowPassword.value = !isShowPassword.value,
                  child: Icon(
                      !value ? Icons.visibility_off : Icons.remove_red_eye,
                      color: context.bodyMedium!.color!.withOpacity(0.5))));
        });
  }

  Widget _buildValidPassword() {
    return SizedBox(
      width: 360,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _oneUpperCase, label: 'Ký tự hoa'),
                  _buildItemValidPassword(
                      valueListenable: _oneLowerCase, label: 'Ký tự thường')
                ])),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _oneNumericNumber, label: 'Ký tự số'),
                  _buildItemValidPassword(
                      valueListenable: _oneSpecialCharacter,
                      label: 'Ký tự đặc biệt')
                ])),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _least8Characters,
                      label: 'Ít nhất 8 ký tự')
                ]))
          ]),
    );
  }
}
