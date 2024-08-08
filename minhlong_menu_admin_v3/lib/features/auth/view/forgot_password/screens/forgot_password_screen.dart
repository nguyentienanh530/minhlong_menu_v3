import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/theme/cubit/theme_cubit.dart';

import '../../../../../Routes/app_route.dart';
import '../../../../../common/widget/common_text_field.dart';
import '../../../../../core/app_asset.dart';
import '../../../../../core/app_const.dart';
import '../../../../../core/app_res.dart';
import '../../../../../core/app_string.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../data/dto/login_dto.dart';
part '../widgets/_forgot_password_body.dart';
part '../widgets/_phone_number_text_field.dart';
part '../widgets/_password_text_field.dart';
part '../widgets/_confirm_password_text_field.dart';

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
    var isDarkMode = context.watch<ThemeCubit>().state;
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
                isDarkMode ? AppAsset.backgroundDark : AppAsset.backgroundLight,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultBorderRadius)),
                margin: const EdgeInsets.all(20),
                surfaceTintColor: context.colorScheme.surfaceTint,
                elevation: 1,
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
                                    style: context.bodySmall)
                              ],
                            ),
                          ),
                          30.verticalSpace,
                          _buildPhoneNumberTextField,
                          36.verticalSpace,
                          _buildPasswordTextField,
                          36.verticalSpace,
                          _buildComfirmPasswordField,
                          10.verticalSpace,
                          SizedBox(
                            width: 360,
                            child: Text(
                              '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
                              style: context.bodySmall!.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          36.verticalSpace,
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
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    backgroundColor:
                                        context.colorScheme.primary),
                                onPressed: () => _handleForgotPassword(),
                                child: Text('Đặt lại mật khẩu',
                                    style: context.bodyMedium!
                                        .copyWith(color: Colors.white)),
                              )),
                          16.verticalSpace,
                          _buildHaveAccount(),
                          66.verticalSpace,
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
        style: context.bodyMedium!
            .copyWith(fontSize: 36, fontWeight: FontWeight.w700));
  }

  Widget _buildHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Đã có tài khoản,',
          style: context.bodyMedium,
        ),
        const SizedBox(width: defaultPadding / 2),
        GestureDetector(
          onTap: () => context.go(AppRoute.login),
          child: Text(
            'Quay lại đăng nhập',
            style: context.bodyMedium!.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
