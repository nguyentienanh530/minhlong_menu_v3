import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../bloc/user_bloc.dart';
import '../../data/repositories/user_repository.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepository: context.read<UserRepo>()),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
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
        title: Text('Đổi mật khẩu', style: context.titleStyleMedium),
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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserUpdatePasswordInProgress():
            AppDialog.showLoadingDialog(context);
            break;
          case UserUpdatePasswordSuccess():
            pop(context, 1);
            OverlaySnackbar.show(context, 'Thao tác thành công');
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            break;
          case UserUpdatePasswordFailure():
            pop(context, 1);
            OverlaySnackbar.show(context, state.errorMessage,
                type: OverlaySnackbarType.error);
            break;
          default:
        }
      },
      child: Padding(
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
                  style: context.bodyMedium!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.5))),
              40.verticalSpace,
              _buttonChangePassword(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonChangePassword() {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary),
          onPressed: () {
            if (AppKeys.updatePasswordKey.currentState!.validate()) {
              context.read<UserBloc>().add(UserUpdatePasswordStarted(
                    oldPassword: _oldPasswordController.text,
                    newPassword: _newPasswordController.text,
                  ));
            }
          },
          child: Text(
            'Thay đổi mật khẩu',
            style: context.bodyMedium!.copyWith(color: Colors.white),
          )),
    );
  }

  Widget _buildOldPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowOldPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: context.bodyMedium,
            controller: _oldPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.oldPassword} *',
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            labelStyle: context.titleStyleMedium!.copyWith(
                color: context.titleStyleMedium!.color!.withOpacity(0.5)),
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.titleStyleMedium!.color!.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () =>
                    _isShowOldPassword.value = !_isShowOldPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: context.titleStyleMedium!.color!.withOpacity(0.5))));
      },
    );
  }

  Widget _buildNewPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowNewPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: context.bodyMedium,
            controller: _newPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.newPassword} *',
            labelStyle: context.titleStyleMedium!.copyWith(
                color: context.titleStyleMedium!.color!.withOpacity(0.5)),
            validator: (password) => AppRes.validatePassword(password)
                ? null
                : 'Mật khẩu không hợp lệ',
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.titleStyleMedium!.color!.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () =>
                    _isShowNewPassword.value = !_isShowNewPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: context.titleStyleMedium!.color!.withOpacity(0.5))));
      },
    );
  }

  Widget _buildComfirmPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowConfirmPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: context.bodyMedium,
            controller: _confirmPasswordController,
            onFieldSubmitted: (p0) {},
            labelText: '${AppString.reNewPassword} *',
            labelStyle: context.titleStyleMedium!.copyWith(
                color: context.titleStyleMedium!.color!.withOpacity(0.5)),
            validator: (value) {
              if (_newPasswordController.text !=
                  _confirmPasswordController.text) {
                return 'Xác nhận mật khẩu không khớp';
              }
              return AppRes.validatePassword(value)
                  ? null
                  : 'mật khẩu không hợp lệ';
            },
            onChanged: (value) {},
            obscureText: !value,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.titleStyleMedium!.color!.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
                onTap: () => _isShowConfirmPassword.value =
                    !_isShowConfirmPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: context.titleStyleMedium!.color!.withOpacity(0.5))));
      },
    );
  }
}
