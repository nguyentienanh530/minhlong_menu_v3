part of '../screen/login_screen.dart';

extension on _LoginScreenState {
  Widget get _buildValidPassword => SizedBox(
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
                      valueListenable: _oneLowerCase, label: 'Ký tự thường'),
                  _buildItemValidPassword(
                      valueListenable: _least8Characters,
                      label: 'Ít nhất 8 ký tự'),
                ],
              ),
            ),
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
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildItemValidPassword(
      {required ValueListenable<bool> valueListenable, required String label}) {
    return FittedBox(
      child: ValueListenableBuilder<bool>(
        valueListenable: valueListenable,
        builder: (context, value, child) => Row(
          children: [
            Icon(Icons.check_circle_rounded,
                size: 15, color: value ? Colors.green : null),
            const SizedBox(width: 8),
            Text(
              label,
              style: context.bodySmall!.copyWith(
                color: value ? Colors.green : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
