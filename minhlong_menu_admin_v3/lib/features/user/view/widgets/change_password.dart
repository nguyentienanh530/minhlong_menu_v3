import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _isShowOldPassword = ValueNotifier(false);
  final _isShowNewPassword = ValueNotifier(false);
  final _isShowConfirmPassword = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _isShowOldPassword.dispose();
    _isShowNewPassword.dispose();
    _isShowConfirmPassword.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChangePassword();
  }

  Widget _buildChangePassword() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(AppString.changePassword,
                style: kHeadingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppColors.secondTextColor)),
          ),
          20.verticalSpace,
          5.verticalSpace,
          _buildOldPassworTextField(),
          20.verticalSpace,
          5.verticalSpace,
          _buildNewPassworTextField(),
          20.verticalSpace,
          5.verticalSpace,
          _buildComfirmPassworTextField(),
          40.verticalSpace,
          _buttonChangePassword(),
        ],
      ),
    );
  }

  Widget _buttonChangePassword() {
    return Center(
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.themeColor),
          onPressed: () {},
          child: Text(
            AppString.edit,
            style: kBodyWhiteStyle,
          )),
    );
  }

  Widget _buildOldPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowOldPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _oldPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.oldPassword} *',
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.secondTextColor.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () =>
                    _isShowOldPassword.value = !_isShowOldPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }

  Widget _buildNewPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowNewPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _newPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.newPassword} *',
            labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.secondTextColor.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () =>
                    _isShowNewPassword.value = !_isShowNewPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }

  Widget _buildComfirmPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowConfirmPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _confirmPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.reNewPassword} *',
            labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.secondTextColor.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () => _isShowConfirmPassword.value =
                    !_isShowConfirmPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }
}
