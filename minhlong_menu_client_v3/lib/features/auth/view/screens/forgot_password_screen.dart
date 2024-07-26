import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/core/app_asset.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import '../../bloc/auth_bloc.dart';
import '../../data/dto/login_dto.dart';

part '../widgets/_forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(context.read<AuthRepository>()),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _isShowPassword = ValueNotifier(false);
  final _isShowConfirmPassword = ValueNotifier(false);

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isShowPassword.dispose();
    _isShowConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: context.sizeDevice.height,
              width: context.sizeDevice.width,
              child: Image.asset(AppAsset.background, fit: BoxFit.cover),
            ),
            _buildFormForgotPassword(),
            Positioned(
                top: 20,
                left: 10,
                child: CommonBackButton(
                  onTap: () => context.pop(),
                )),
          ],
        ));
  }

  Widget _buildFormForgotPassword() {
    return Card(
      elevation: 10,
      color: AppColors.white.withOpacity(.9),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(35).r,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthForgotPasswordInProgress) {
                AppDialog.showLoadingDialog(context);
              }
              if (state is AuthForgotPasswordSuccess) {
                context.pop();
                _phoneController.clear();
                _passwordController.clear();
                _confirmPasswordController.clear();
                AppSnackbar.showSnackBar(context,
                    msg: 'Đổi mật khẩu thành công!', isSuccess: true);
              }
              if (state is AuthForgotPasswordFailure) {
                context.pop();
                AppSnackbar.showSnackBar(context,
                    msg: state.message, isSuccess: false);
              }
            },
            child: SizedBox(
              width: 360,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    20.verticalSpace,
                    _buildForgotPasswordWidget(),
                    Text('Nhập số điện thoại của bạn để đổi mật khẩu',
                        style: kBodyStyle.copyWith(
                            fontSize: 14,
                            color: AppColors.black.withOpacity(0.7))),
                    20.verticalSpace,
                    _buildPhoneField(),
                    20.verticalSpace,
                    _buildPasswordField(),
                    20.verticalSpace,
                    _buildComfirmPasswordField(),
                    10.verticalSpace,
                    SizedBox(
                      width: 360,
                      child: Text(
                        '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
                        style: kCaptionWhiteStyle.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      textFieldBorderRadius * 10)),
                              side:
                                  const BorderSide(color: AppColors.themeColor),
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: AppColors.themeColor),
                          onPressed: () => _handleForgotPassword(),
                          child: const Text('Đặt lại mật khẩu',
                              style: kButtonWhiteStyle),
                        )),
                    16.verticalSpace,
                    _buildHaveAccount(),
                    20.verticalSpace,
                  ]
                      .animate(interval: 50.ms)
                      .slideX(
                          begin: -0.1,
                          end: 0,
                          curve: Curves.easeInOutCubic,
                          duration: 400.ms)
                      .fadeIn(
                        curve: Curves.easeInOutCubic,
                        duration: 400.ms,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() => CommonTextField(
        controller: _phoneController,
        onChanged: (p0) {},
        keyboardType: TextInputType.phone,
        maxLines: 1,
        validator: (value) {
          return AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ';
        },
        labelText: 'Số điện thoại',
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: AppColors.black.withOpacity(0.9),
        ),
      );

  Widget _buildPasswordField() => ValueListenableBuilder(
      valueListenable: _isShowPassword,
      builder: (context, value, child) => CommonTextField(
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
              color: AppColors.black.withOpacity(0.9),
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
                color: AppColors.black.withOpacity(0.9),
              ),
            ),
          ));

  Widget _buildComfirmPasswordField() => ValueListenableBuilder(
        valueListenable: _isShowConfirmPassword,
        builder: (context, value, child) => CommonTextField(
          controller: _confirmPasswordController,
          onChanged: (p0) {},
          keyboardType: TextInputType.visiblePassword,
          maxLines: 1,
          validator: (value) {
            if (_passwordController.text != _confirmPasswordController.text) {
              return 'Xác nhận mật khẩu không khớp';
            }
            return AppRes.validatePassword(value)
                ? null
                : 'mật khẩu không hợp lệ';
          },
          labelText: 'Xác nhận mật khẩu',
          obscureText: !value,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: AppColors.black.withOpacity(0.9),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _isShowConfirmPassword.value = !_isShowConfirmPassword.value;
            },
            child: Icon(
              value
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: AppColors.black.withOpacity(0.9),
            ),
          ),
        ),
      );

  _handleForgotPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var loginModel = LoginDto(
          phoneNumber: int.parse(_phoneController.text.trim()),
          password: _passwordController.text.trim());
      _forgotPassword(loginModel);
    }
  }

  void _forgotPassword(LoginDto loginModel) {
    context.read<AuthBloc>().add(AuthForgotPasswordStarted(loginModel));
  }

  Widget _buildForgotPasswordWidget() {
    return FittedBox(
      child: Text(AppString.forgotPassword.removeLast().toUpperCase(),
          style: kHeadingStyle.copyWith(
              fontSize: 35.sp, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildHaveAccount() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Đã có tài khoản,', style: kButtonStyle),
      const SizedBox(width: defaultPadding / 2),
      GestureDetector(
          onTap: () => context.pop(),
          child: Text('Quay lại đăng nhập',
              style: kBodyWhiteStyle.copyWith(
                  color: AppColors.themeColor.withOpacity(0.6),
                  fontWeight: FontWeight.bold)))
    ]);
  }
}
