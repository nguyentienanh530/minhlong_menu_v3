import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widgets/loading_widget.dart';
import 'package:minhlong_menu_client_v3/core/app_asset.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/theme/cubit/theme_cubit.dart';
import '../../../../../Routes/app_route.dart';
import '../../../../../common/widgets/common_text_field.dart';
import '../../../../../common/widgets/error_widget.dart';
import '../../../../../core/app_const.dart';
import '../../../../../core/app_res.dart';
import '../../../../../core/app_string.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../data/dto/login_dto.dart';
part '../widgets/_phone_number_text_field.dart';
part '../widgets/_password_text_field.dart';
part '../widgets/_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = context.watch<ThemeCubit>().state;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.sizeDevice.height,
            width: context.sizeDevice.width,
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
      elevation: 1,
      surfaceTintColor: context.colorScheme.surfaceTint,
      child: FittedBox(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(35).r,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultPadding.verticalSpace,
                const Center(child: _Wellcome()),
                (defaultPadding * 2).verticalSpace,
                _phoneNumberTextField,
                defaultPadding.verticalSpace,
                _buildPasswordTextField(),
                defaultPadding.verticalSpace,
                const SizedBox(
                  width: 360,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_ButtonForgotPassword()]),
                ),
                defaultPadding.verticalSpace,
                _buildValidPassword(),
                defaultPadding.verticalSpace,
                _loginButton,
                defaultPadding.verticalSpace,
              ]
                  .animate(interval: 50.ms)
                  .slideX(
                      begin: -0.1,
                      end: 0,
                      curve: Curves.easeInOutCubic,
                      duration: 400.ms)
                  .fadeIn(curve: Curves.easeInOutCubic, duration: 400.ms),
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

  void _retryLogin() {
    context.read<AuthBloc>().add(AuthEventStarted());
  }

  Widget _buildItemValidPassword({
    required ValueListenable<bool> valueListenable,
    required String label,
  }) {
    return FittedBox(
      child: ValueListenableBuilder<bool>(
        valueListenable: valueListenable,
        builder: (context, value, child) => Row(
          children: [
            Icon(Icons.check_circle_rounded,
                size: 15,
                color: value
                    ? context.colorScheme.primary.withOpacity(0.7)
                    : context.bodySmall!.color!.withOpacity(0.5)),
            const SizedBox(width: 8),
            Text(
              label,
              style: context.bodySmall!.copyWith(
                color: value
                    ? context.colorScheme.primary.withOpacity(0.7)
                    : context.bodySmall!.color!.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Wellcome extends StatelessWidget {
  const _Wellcome();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        AppString.welcomeBack,
        style: context.titleStyleLarge!.copyWith(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ButtonForgotPassword extends StatelessWidget {
  const _ButtonForgotPassword();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push(AppRoute.forgotPassword);
        },
        child: Text(AppString.forgotPassword,
            style: context.bodyMedium!
                .copyWith(color: context.colorScheme.primary)));
  }
}
