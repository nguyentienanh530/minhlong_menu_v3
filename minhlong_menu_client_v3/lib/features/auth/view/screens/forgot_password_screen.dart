import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/core/app_asset.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/common_back_button.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../theme/cubit/theme_cubit.dart';
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
    var isDarkMode = context.watch<ThemeCubit>().state;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: context.sizeDevice.height,
              width: context.sizeDevice.width,
              child: Image.asset(
                  isDarkMode
                      ? AppAsset.backgroundDark
                      : AppAsset.backgroundLight,
                  fit: BoxFit.cover),
            ),
            _buildFormForgotPassword(),
            Positioned(
                top: 20,
                left: 10,
                child: CommonBackButton(onTap: () => context.pop())),
          ],
        ));
  }

  Widget _buildFormForgotPassword() {
    return Card(
      elevation: 10,
      color: context.colorScheme.surface.withOpacity(0.9),
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
                    msg: 'Đổi mật khẩu thành công!',
                    type: AppSnackbarType.success);
              }
              if (state is AuthForgotPasswordFailure) {
                context.pop();
                AppSnackbar.showSnackBar(context,
                    msg: state.message, type: AppSnackbarType.error);
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
                    _buildForgotPasswordTittleWidget(),
                    Text('Nhập số điện thoại của bạn để đổi mật khẩu',
                        style: context.bodySmall!.copyWith(
                            fontSize: 14,
                            color: context.bodySmall!.color!.withOpacity(0.5))),
                    20.verticalSpace,
                    _buildPhoneField(),
                    20.verticalSpace,
                    _buildPasswordField(),
                    20.verticalSpace,
                    _buildConfirmPasswordField(),
                    10.verticalSpace,
                    SizedBox(
                      width: 360,
                      child: Text(
                        '*Mật khẩu ít nhất 8 ký tự, bao gồm(ký tự hoa, ký tự thường, ký tự số, ký tự đặc biệt)',
                        style: context.bodySmall!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: context.bodySmall!.color!.withOpacity(0.7),
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
                              side: BorderSide(
                                  color: context.colorScheme.primary),
                              foregroundColor: context.colorScheme.onPrimary,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              backgroundColor: context.colorScheme.primary),
                          onPressed: () => _handleForgotPassword(),
                          child: Text('Đặt lại mật khẩu',
                              style: context.bodyMedium!.copyWith(
                                  color: context.colorScheme.onPrimary)),
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

  Widget _buildConfirmPasswordField() {
    return ListenableBuilder(
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
            onTap: () =>
                _isShowConfirmPassword.value = !_isShowConfirmPassword.value,
            child: Icon(
              !_isShowConfirmPassword.value
                  ? Icons.visibility_off
                  : Icons.remove_red_eye,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return ListenableBuilder(
      listenable: _isShowPassword,
      builder: (context, _) {
        return CommonTextField(
          maxLines: 1,
          controller: _passwordController,
          onFieldSubmitted: (p0) {},
          labelText: AppString.newPassword,
          validator: (password) => AppRes.validatePassword(password)
              ? null
              : 'Mật khẩu không hợp lệ',
          onChanged: (value) {},
          obscureText: !_isShowPassword.value,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: context.colorScheme.primary.withOpacity(0.8),
          ),
          suffixIcon: GestureDetector(
            onTap: () => _isShowPassword.value = !_isShowPassword.value,
            child: Icon(
              !_isShowPassword.value
                  ? Icons.visibility_off
                  : Icons.remove_red_eye,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
          ),
        );
      },
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
        labelStyle: context.bodyMedium,
        style: context.bodyMedium,
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: context.colorScheme.primary.withOpacity(0.9),
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

  Widget _buildForgotPasswordTittleWidget() {
    return FittedBox(
      child: Text(AppString.forgotPassword.removeLast().toUpperCase(),
          style: context.titleStyleLarge!
              .copyWith(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Đã có tài khoản,',
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.6))),
        const SizedBox(width: defaultPadding / 2),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(
            'Quay lại đăng nhập',
            style: context.bodyMedium!.copyWith(
              color: context.colorScheme.primary.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
