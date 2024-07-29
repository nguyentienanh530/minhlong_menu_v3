import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/common_password_textfield.dart';
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
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: CommonBackButton(onTap: () => context.pop()),
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
                msg: 'Thao tác thành công', isSuccess: true);
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            break;
          case UserUpdatePasswordFailure():
            pop(context, 1);
            AppSnackbar.showSnackBar(context,
                msg: state.errorMessage, isSuccess: false);
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
              TextFieldPassword(
                controller: _oldPasswordController,
                labelText: AppString.oldPassword,
                validator: (password) => AppRes.validatePassword(password)
                    ? null
                    : 'Mật khẩu không hợp lệ',
                valueListenable: _isShowOldPassword,
              ),
              20.verticalSpace,
              TextFieldPassword(
                valueListenable: _isShowNewPassword,
                labelText: AppString.newPassword,
                controller: _newPasswordController,
                validator: (password) => AppRes.validatePassword(password)
                    ? null
                    : 'Mật khẩu không hợp lệ',
              ),
              20.verticalSpace,
              TextFieldPassword(
                valueListenable: _isShowConfirmPassword,
                controller: _confirmPasswordController,
                labelText: AppString.confirNewPassword,
                validator: (value) {
                  if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    return 'Xác nhận mật khẩu không khớp';
                  }
                  return AppRes.validatePassword(value)
                      ? null
                      : 'mật khẩu không hợp lệ';
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
              backgroundColor: context.colorScheme.secondary),
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
