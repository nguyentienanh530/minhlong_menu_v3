part of '../screen/change_password_screen.dart';

extension _ChangePasswordWidget on _ChangePasswordScreenState {
  Widget _buildChangePasswordWidget() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextBoxProfile(
          labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          controllers: _oldPwController,
          labelText: AppString.oldPassword,
        ),
        20.verticalSpace,
        TextBoxProfile(
          labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          controllers: _newPwController,
          labelText: AppString.newPassword,
        ),
        20.verticalSpace,
        TextBoxProfile(
          labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          controllers: _reNewPwController,
          labelText: AppString.reNewPassword,
        ),
        40.verticalSpace,
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
