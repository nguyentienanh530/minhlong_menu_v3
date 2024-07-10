part of '../screen/profile_screen.dart';

extension _ProfileWidget on _ProfileScreenState {
  Widget _imageProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
