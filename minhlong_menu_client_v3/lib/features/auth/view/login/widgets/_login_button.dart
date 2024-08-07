part of '../screens/login_screen.dart';

extension on _LoginScreenState {
  Widget get _loginButton => SizedBox(
        width: 360,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(textFieldBorderRadius * 10)),
              side: BorderSide(color: context.colorScheme.primary),
              foregroundColor: context.colorScheme.onPrimary,
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: context.colorScheme.primary),
          onPressed: () {
            _handleLoginSubmited();
          },
          child: Text(
            AppString.login,
            style: context.bodyMedium!.copyWith(
              fontSize: 15,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
      );

  void _handleLoginSubmited() async {
    if (_formKey.currentState!.validate()) {
      final login = LoginDto(
          phoneNumber: int.parse(_phoneCtrl.text.trim()),
          password: _passwordCtrl.text.trim());
      context.read<AuthBloc>().add(AuthLoginStarted(login));
    }
  }
}
