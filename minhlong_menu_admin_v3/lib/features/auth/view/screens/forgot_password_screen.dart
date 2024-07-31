import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import '../../bloc/auth_bloc.dart';
import '../../data/dto/login_dto.dart';

part '../widgets/_forgot_password_body.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _isShowPassword = ValueNotifier(false);
  final _isShowConfirmPassword = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _formKey.currentState?.dispose();
    _isShowPassword.dispose();
    _isShowConfirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotPasswordInProgress) {
          AppDialog.showLoadingDialog(context);
        }
        if (state is AuthForgotPasswordSuccess) {
          context.pop();
          AppDialog.showSuccessDialog(
            context,
            title: 'Thành công!',
            confirmText: 'Về đăng nhập',
            onPressedComfirm: () {
              context.read<AuthBloc>().add(AuthEventStarted());
              context.pushReplacement(AppRoute.login);
            },
          );
        }
        if (state is AuthForgotPasswordFailure) {
          context.pop();
          AppDialog.showErrorDialog(context,
              confirmText: 'Thử lại',
              description: state.message, onPressedComfirm: () {
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                AppAsset.backgroundLogin,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius)),
                margin: const EdgeInsets.all(20),
                color: AppColors.white.withOpacity(0.2),
                elevation: 30,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 66),
                          SizedBox(
                              height: 96,
                              child: Column(
                                children: [
                                  _buildForgotPasswordWidget(),
                                  Text(
                                      'Nhập số điện thoại của bạn để đổi mật khẩu',
                                      style: kBodyStyle.copyWith(
                                          fontSize: 10,
                                          color:
                                              AppColors.white.withOpacity(0.5)))
                                ],
                              )),
                          const SizedBox(height: 30),
                          _buildPhoneField(),
                          const SizedBox(height: 36),
                          _buildPasswordField(),
                          const SizedBox(height: 36),
                          _buildComfirmPasswordField(),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 360,
                            child: Text(
                              '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
                              style: kCaptionWhiteStyle.copyWith(
                                fontStyle: FontStyle.italic,
                                color: AppColors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                              width: 360,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            textFieldBorderRadius)),
                                    side: BorderSide(
                                        color: context.colorScheme.primary),
                                    foregroundColor: AppColors.white,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    backgroundColor:
                                        context.colorScheme.primary),
                                onPressed: () => _handleForgotPassword(),
                                child: const Text('Đặt lại mật khẩu',
                                    style: kButtonWhiteStyle),
                              )),
                          const SizedBox(height: defaultPadding),
                          _buildHaveAccount(),
                          const SizedBox(height: 66),
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() => SizedBox(
        width: 360,
        child: CommonTextField(
          controller: _phoneController,
          style: kBodyWhiteStyle,
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
            color: AppColors.white.withOpacity(0.5),
          ),
        ),
      );

  Widget _buildPasswordField() => ValueListenableBuilder(
      valueListenable: _isShowPassword,
      builder: (context, value, child) => SizedBox(
            width: 360,
            child: CommonTextField(
              style: kBodyWhiteStyle,
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
                color: AppColors.white.withOpacity(0.5),
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
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ),
          ));

  Widget _buildComfirmPasswordField() => ValueListenableBuilder(
        valueListenable: _isShowConfirmPassword,
        builder: (context, value, child) => SizedBox(
          width: 360,
          child: CommonTextField(
            style: kBodyWhiteStyle,
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
              color: AppColors.white.withOpacity(0.5),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _isShowConfirmPassword.value = !_isShowConfirmPassword.value;
              },
              child: Icon(
                value
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.white.withOpacity(0.5),
              ),
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
    return Text(AppString.forgotPassword.removeLast().toUpperCase(),
        style: kHeadingWhiteStyle.copyWith(
            fontSize: 36, fontWeight: FontWeight.w700));
  }

  Widget _buildHaveAccount() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Đã có tài khoản,', style: kButtonWhiteStyle),
      const SizedBox(width: defaultPadding / 2),
      GestureDetector(
          onTap: () => context.go(AppRoute.login),
          child: Text('Quay lại đăng nhập',
              style: kBodyWhiteStyle.copyWith(
                  color: AppColors.sun, fontWeight: FontWeight.bold)))
    ]);
  }
}
