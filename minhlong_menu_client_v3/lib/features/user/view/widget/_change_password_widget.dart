part of '../screen/change_password_screen.dart';

extension _ChangePasswordWidget on _ChangePasswordScreenState {
  Widget _buildChangePasswordWidget() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        BuildPassword(
          controller: _oldPwController,
          textLabel: AppString.oldPassword,
        ),
        20.verticalSpace,
        BuildPassword(
            controller: _newPwController, textLabel: AppString.newPassword),
        20.verticalSpace,
        BuildPassword(
            controller: _reNewPwController, textLabel: AppString.reNewPassword),
        10.verticalSpace,
        Text(
          'Mật khẩu it nhất 8 ký tự, bao gồm(ký tự hoa(Aa..),số(123..), đặc biệt(@#!..)) ',
          style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
        ),
        20.verticalSpace,
        _changePasswordButtonWidget(),
      ]),
    );
  }

  Widget _changePasswordButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
              ),
              onPressed: () {},
              child: Text(
                AppString.changePassword,
                style: kBodyWhiteStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildPassword extends StatelessWidget {
  BuildPassword({
    super.key,
    required this.controller,
    this.textLabel,
  });
  final TextEditingController controller;
  final String? textLabel;

  final isShowPassword = ValueNotifier(false);
  final _oneUpperCase = ValueNotifier(false);
  final _oneLowerCase = ValueNotifier(false);
  final _oneNumericNumber = ValueNotifier(false);
  final _oneSpecialCharacter = ValueNotifier(false);
  final _least8Characters = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isShowPassword,
        builder: (context, value, child) {
          return CommonTextField(
              maxLines: 1,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondTextColor),
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultPadding - 4))),
              controller: controller,
              labelText: textLabel,
              labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
              validator: (password) => AppRes.validatePassword(password)
                  ? null
                  : 'Mật khẩu không hợp lệ',
              onChanged: (value) {
                // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                controller.text = value;
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
              prefixIcon: Icon(Icons.lock,
                  color: AppColors.secondTextColor.withOpacity(0.5)),
              suffixIcon: GestureDetector(
                  onTap: () => isShowPassword.value = !isShowPassword.value,
                  child: Icon(
                      !value ? Icons.visibility_off : Icons.remove_red_eye,
                      color: AppColors.secondTextColor.withOpacity(0.5))));
        });
  }
}
