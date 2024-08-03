import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading_widget.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/theme/cubit/theme_cubit.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../bloc/auth_bloc.dart';
import '../../data/dto/login_dto.dart';

part '../widgets/_login_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl =
      TextEditingController(text: '0328023993');
  final TextEditingController _passwordCtrl =
      TextEditingController(text: 'Minhlong@123');
  final _formKey = GlobalKey<FormState>();
  final _oneUpperCase = ValueNotifier(false);
  final _oneLowerCase = ValueNotifier(false);
  final _oneNumericNumber = ValueNotifier(false);
  final _oneSpecialCharacter = ValueNotifier(false);
  final _least8Characters = ValueNotifier(false);

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _oneUpperCase.dispose();
    _oneLowerCase.dispose();
    _oneNumericNumber.dispose();
    _oneSpecialCharacter.dispose();
    _least8Characters.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.watch<ThemeCubit>().state;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              isDarkMode ? AppAsset.backgroundDark : AppAsset.backgroundLight,
              fit: BoxFit.cover,
            ),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    var isShowPassword = ValueNotifier(false);
    return ValueListenableBuilder(
        valueListenable: isShowPassword,
        builder: (context, value, child) {
          return CommonTextField(
              maxLines: 1,
              style: context.bodyMedium!
                  .copyWith(color: context.bodyMedium!.color),
              controller: _passwordCtrl,
              onFieldSubmitted: (p0) {
                _handleLoginSubmited();
              },
              labelStyle: context.bodyMedium,
              labelText: AppString.password,
              // labelText: AppString.password,
              validator: (password) => AppRes.validatePassword(password)
                  ? null
                  : 'Mật khẩu không hợp lệ',
              onChanged: (value) {
                // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                _passwordCtrl.text = value;
                RegExp(r'^(?=.*?[A-Z])').hasMatch(value)
                    ? _oneUpperCase.value = true
                    : _oneUpperCase.value = false;
                RegExp(r'^(?=.*?[a-z])').hasMatch(value)
                    ? _oneLowerCase.value = true
                    : _oneLowerCase.value = false;
                RegExp(r'^(?=.*?[a-z])').hasMatch(value)
                    ? _oneLowerCase.value = true
                    : _oneLowerCase.value = false;
                RegExp(r'^(?=.*?[0-9])').hasMatch(value)
                    ? _oneNumericNumber.value = true
                    : _oneNumericNumber.value = false;
                RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)
                    ? _oneSpecialCharacter.value = true
                    : _oneSpecialCharacter.value = false;
                value.length >= 8
                    ? _least8Characters.value = true
                    : _least8Characters.value = false;
              },
              obscureText: !value,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: context.bodyMedium!.color!.withOpacity(0.5),
              ),
              suffixIcon: GestureDetector(
                  onTap: () => isShowPassword.value = !isShowPassword.value,
                  child: Icon(
                      !value ? Icons.visibility_off : Icons.remove_red_eye,
                      color: context.bodyMedium!.color!.withOpacity(0.5))));
        });
  }

  Widget _buildValidPassword() {
    return SizedBox(
      width: 360,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _oneUpperCase, label: 'Ký tự hoa'),
                  _buildItemValidPassword(
                      valueListenable: _oneLowerCase, label: 'Ký tự thường')
                ])),
            16.verticalSpace,
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _oneNumericNumber, label: 'Ký tự số'),
                  _buildItemValidPassword(
                      valueListenable: _oneSpecialCharacter,
                      label: 'Ký tự đặc biệt')
                ])),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildItemValidPassword(
                      valueListenable: _least8Characters,
                      label: 'Ít nhất 8 ký tự')
                ]))
          ]),
    );
  }

  Widget _buildItemValidPassword(
      {required ValueListenable<bool> valueListenable, required String label}) {
    return FittedBox(
        child: ValueListenableBuilder<bool>(
            valueListenable: valueListenable,
            builder: (context, value, child) => Row(children: [
                  Icon(Icons.check_circle_rounded,
                      size: 15,
                      color:
                          value ? Colors.green : Colors.white.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(label,
                      style: context.bodyMedium!.copyWith(
                          color: value
                              ? Colors.green
                              : Colors.white.withOpacity(0.5)))
                ])));
  }
}

class _Wellcome extends StatelessWidget {
  const _Wellcome();

  @override
  Widget build(BuildContext context) {
    return Text(AppString.welcomeBack.toUpperCase(),
        style: context.titleStyleLarge!
            .copyWith(fontSize: 36, fontWeight: FontWeight.bold));
  }
}

class _PhoneNumber extends StatelessWidget {
  const _PhoneNumber({required this.emailcontroller, required this.onSubmit});
  final TextEditingController emailcontroller;
  final Function(String)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return CommonTextField(
        controller: emailcontroller,
        keyboardType: TextInputType.phone,
        labelText: AppString.phoneNumber,
        validator: (value) {
          return AppRes.validatePhoneNumber(value)
              ? null
              : 'Số điện thoại không hợp lệ';
        },
        prefixIcon: Icon(
          Icons.phone_android_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.5),
        ),
        style: context.bodyMedium!.copyWith(color: context.bodyMedium!.color),
        onFieldSubmitted: onSubmit,
        onChanged: (value) => emailcontroller.text = value);
  }
}

class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // return CommonButton(text: AppString.login, onTap: onTap);
    return SizedBox(
        width: 360,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(textFieldBorderRadius)),
              side: BorderSide(color: context.colorScheme.primary),
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: context.colorScheme.primary),
          onPressed: onTap,
          child: Text(AppString.login,
              style: context.bodyMedium!
                  .copyWith(fontSize: 15, color: Colors.white)),
        ));
  }
}

class _ButtonForgotPassword extends StatelessWidget {
  const _ButtonForgotPassword();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.go(AppRoute.forgotPassword);
        },
        child: Text(AppString.forgotPassword,
            style: context.bodyMedium!.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold)));
  }
}
