import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/extensions.dart';
import '../../bloc/user_bloc.dart';
import '../../data/repositories/user_repository.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(userRepository: context.read<UserRepository>()),
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
          title: Text(AppString.changePassword,
              style: context.titleStyleLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: _buildChangePassword());
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
            AppSnackbar.showSnackBar(context,
                msg: 'Thao tác thành công', type: AppSnackbarType.success);
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            break;
          case UserUpdatePasswordFailure():
            pop(context, 1);
            AppSnackbar.showSnackBar(context,
                msg: state.errorMessage, type: AppSnackbarType.error);
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
              ListenableBuilder(
                listenable: _isShowOldPassword,
                builder: (context, _) {
                  return CommonTextField(
                    maxLines: 1,
                    controller: _oldPasswordController,
                    onFieldSubmitted: (p0) {},
                    labelText: AppString.oldPassword,
                    labelStyle: context.bodyMedium,
                    validator: (password) => AppRes.validatePassword(password)
                        ? null
                        : 'Mật khẩu không hợp lệ',
                    onChanged: (value) {},
                    obscureText: !_isShowOldPassword.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colorScheme.primary.withOpacity(0.8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(defaultBorderRadius / 3),
                      borderSide: BorderSide(
                        color: context.colorScheme.primary,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          _isShowOldPassword.value = !_isShowOldPassword.value,
                      child: Icon(
                        !_isShowOldPassword.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        color: context.bodyMedium!.color!.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              ListenableBuilder(
                listenable: _isShowNewPassword,
                builder: (context, _) {
                  return CommonTextField(
                    maxLines: 1,
                    controller: _newPasswordController,
                    onFieldSubmitted: (p0) {},
                    labelText: AppString.newPassword,
                    validator: (password) => AppRes.validatePassword(password)
                        ? null
                        : 'Mật khẩu không hợp lệ',
                    onChanged: (value) {},
                    obscureText: !_isShowNewPassword.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colorScheme.primary.withOpacity(0.8),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          _isShowNewPassword.value = !_isShowNewPassword.value,
                      child: Icon(
                        !_isShowNewPassword.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        color: context.bodyMedium!.color!.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              ListenableBuilder(
                listenable: _isShowConfirmPassword,
                builder: (context, _) {
                  return CommonTextField(
                    maxLines: 1,
                    controller: _confirmPasswordController,
                    onFieldSubmitted: (p0) {},
                    labelText: AppString.confirmPassword,
                    validator: (password) => AppRes.validatePassword(password)
                        ? null
                        : 'Mật khẩu không hợp lệ',
                    onChanged: (value) {},
                    obscureText: !_isShowConfirmPassword.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colorScheme.primary.withOpacity(0.8),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => _isShowConfirmPassword.value =
                          !_isShowConfirmPassword.value,
                      child: Icon(
                        !_isShowConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        color: context.bodyMedium!.color!.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              Text(
                  'Mật khẩu bao gồm (1 ký tự Hoa, 1 ký tự Thường, 1 ký tự số, 1 ký tự đặc biệt và tối thiểu 8 ký tự)',
                  style: context.bodySmall!.copyWith(
                      color: context.bodySmall!.color!.withOpacity(0.5))),
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
            AppString.changePassword,
            style: context.bodyMedium!.copyWith(color: Colors.white),
          )),
    );
  }
}
