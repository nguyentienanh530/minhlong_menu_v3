part of '../screens/home_view.dart';

extension _AppBarWidget on _HomeViewState {
  Widget _seachBox() {
    return CommonTextField(
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadius / 4),
        ),
        borderSide: BorderSide(
          color: AppColors.white,
          width: 1.0,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadius / 4),
        ),
        borderSide: BorderSide(
          color: AppColors.white,
          width: 1.0,
        ),
      ),

      controller: _searchText,
      hintText: AppString.seachLabelText,
      hintStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      onChanged: (p0) {},
      maxLines: 1,
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.secondTextColor,
      ),
      // style: kBodyStyle,
    );
  }

  Widget _iconActionButtonAppBar({IconData? icon, void Function()? onPressed}) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isScrolledNotifier,
        builder: (context, isScrolled, child) {
          return IconButton(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultBorderRadius / 4),
              ),
            ),
            onPressed: onPressed,
            icon: Icon(icon,
                color: _isScrolledNotifier.value
                    ? AppColors.themeColor
                    : AppColors.secondTextColor),
          );
        });
  }
}
