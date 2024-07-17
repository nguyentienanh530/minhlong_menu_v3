part of '../screens/login_screen.dart';

extension _LoginBody on _LoginScreenState {
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
      color: AppColors.white.withOpacity(0.2),
      elevation: 30,
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
                _PhoneNumber(
                    emailcontroller: _emailCtrl,
                    onSubmit: (p0) {
                      _handleLoginSubmited();
                    }),
                36.verticalSpace,
                _buildPassword(),
                20.verticalSpace,
                const SizedBox(
                  width: 360,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_ButtonForgotPassword()]),
                ),
                _buildValidPassword(),
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

  void _handleLoginSubmited() async {
    final login = LoginDto(
        phoneNumber: int.parse(_emailCtrl.text.trim()),
        password: _passwordCtrl.text.trim());
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginStarted(login));
    }
  }

  void _retryLogin() {
    context.read<AuthBloc>().add(AuthEventStarted());
  }
}
