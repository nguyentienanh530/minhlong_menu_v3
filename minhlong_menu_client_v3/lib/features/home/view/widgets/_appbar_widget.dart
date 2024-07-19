part of '../screens/home_view.dart';

extension _AppBarWidget on _HomeViewState {
  Widget _buildSearchWidget() {
    return GestureDetector(
      onTap: () => context.push(AppRoute.search),
      child: Card(
          child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.search, color: AppColors.secondTextColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppString.seachLabelText,
                style: kBodyStyle.copyWith(
                  color: AppColors.secondTextColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      )),
    );
  }

  Widget _iconActionButtonAppBar({IconData? icon, void Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: AppColors.themeColor,
        elevation: 4,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(icon, color: AppColors.white),
        ),
      ),
    );
  }
}
