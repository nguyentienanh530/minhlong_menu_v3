import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_key.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu', style: kHeadingStyle),
        centerTitle: true,
      ),
      body: context.isMobile
          ? Card(child: _buildChangePassword())
          : Row(
              children: [
                const Spacer(),
                Expanded(flex: 2, child: Card(child: _buildChangePassword())),
                const Spacer(),
              ],
            ),
    );
  }

  Widget _buildChangePassword() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Form(
        key: AppKeys.updatePasswordKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOldPassworTextField(),
            20.verticalSpace,
            _buildNewPassworTextField(),
            20.verticalSpace,
            _buildComfirmPassworTextField(),
            20.verticalSpace,
            Text(
                'Mật khẩu bao gồm (1 ký tự Hoa, 1 ký tự Thường, 1 ký tự số, 1 ký tự đặc biệt và tối thiểu 8 ký tự)',
                style:
                    kCaptionStyle.copyWith(color: AppColors.secondTextColor)),
            40.verticalSpace,
            _buttonChangePassword(),
          ],
        ),
      ),
    );
  }

  Widget _buttonChangePassword() {
    return Center(
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.themeColor),
          onPressed: () {
            if (AppKeys.updatePasswordKey.currentState!.validate()) {
              // context.pop();
            }
          },
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
            labelStyle:
                kSubHeadingStyle.copyWith(color: AppColors.secondTextColor),
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
            labelStyle:
                kSubHeadingStyle.copyWith(color: AppColors.secondTextColor),
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
            labelStyle:
                kSubHeadingStyle.copyWith(color: AppColors.secondTextColor),
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
