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
            Icon(Icons.search,
                color: context.textTheme.labelLarge?.color!.withOpacity(0.5)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppString.seachLabelText,
                style: context.labelLarge!.copyWith(
                    color: context.labelLarge!.color!.withOpacity(0.5)),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      )),
    );
  }

  Widget _iconActionButtonAppBar({IconData? icon, void Function()? onPressed}) {
    return InkWell(
        borderRadius: BorderRadius.circular(defaultPadding),
        onTap: onPressed,
        child: Card(
          color: context.colorScheme.primary,
          elevation: 3,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Icon(icon, color: Colors.white),
          ),
        ));
  }
}
