import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading_widget.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/theme/cubit/theme_cubit.dart';
import '../../../../../Routes/app_route.dart';
import '../../../../../common/widget/common_text_field.dart';
import '../../../../../common/widget/error_widget.dart';
import '../../../../../core/app_asset.dart';
import '../../../../../core/app_const.dart';
import '../../../../../core/app_res.dart';
import '../../../../../core/app_string.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../data/dto/login_dto.dart';
part '../widgets/_phone_number_text_field.dart';
part '../widgets/_password_text_field.dart';
part '../widgets/_valid_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneCtrl =
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
    _phoneCtrl.dispose();
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

  Widget _buildBody() {
    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthLoginSuccess():
              context.read<AuthBloc>().add(AuthAuthenticateStarted());
              break;
            case AuthAuthenticateSuccess():
              context.go(AppRoute.home);
              break;
            default:
          }
        },
        builder: (context, state) {
          return (switch (state) {
            AuthAuthenticateUnauthenticated() => _buildLoginInitWidget(),
            AuthLoginInProgress() => const LoadingWidget(title: 'Đăng nhập...'),
            AuthLoginSuccess() => const SizedBox(),
            AuthLoginFailure() => _buildLoginFailureWidget(state.message),
            _ => const SizedBox(),
          });
        },
      ),
    );
  }

  Widget _buildLoginInitWidget() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      margin: const EdgeInsets.all(20),
      surfaceTintColor: context.colorScheme.surfaceTint,
      elevation: 1,
      child: FittedBox(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 44),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: _Wellcome()),
                44.verticalSpace,
                _buildPhoneNumberTextField,
                36.verticalSpace,
                _buildPassword(),
                20.verticalSpace,
                const SizedBox(
                  width: 360,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_ButtonForgotPassword()]),
                ),
                10.verticalSpace,
                _buildValidPassword,
                20.verticalSpace,
                _ButtonLogin(onTap: () {
                  _handleLoginSubmited();
                }),
                40.verticalSpace,
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
    );
  }

  Widget _buildLoginFailureWidget(String message) {
    return ErrWidget(
      error: message,
      onRetryPressed: () {
        _retryLogin();
      },
    );
  }

  void _handleLoginSubmited() async {
    if (_formKey.currentState!.validate()) {
      final login = LoginDto(
          phoneNumber: int.parse(_phoneCtrl.text.trim()),
          password: _passwordCtrl.text.trim());
      context.read<AuthBloc>().add(AuthLoginStarted(login));
    }
  }

  void _retryLogin() {
    context.read<AuthBloc>().add(AuthEventStarted());
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
