part of '../screens/home_view.dart';

extension _AppBarWidget on _HomeViewState {
  SliverAppBar _buildAppBar(UserModel user, TableModel table) {
    return SliverAppBar(
      stretch: true,
      pinned: true,
      titleSpacing: 10,
      toolbarHeight: 80.h,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Card(
              elevation: 4,
              shape: const CircleBorder(),
              child: Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                      imageUrl: '${ApiConfig.host}${user.image}',
                      placeholder: (context, url) => const Loading(),
                      errorWidget: errorBuilderForImage,
                      fit: BoxFit.cover),
                ),
              ),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào!',
                  style: context.bodySmall!.copyWith(
                      color: context.bodySmall!.color!.withOpacity(0.5)),
                ),
                Text(user.fullName,
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w900)),
              ],
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                5.horizontalSpace,
                Expanded(child: _buildSearchWidget()),
                10.horizontalSpace,
                _buildIconTableWidget(table),
                5.horizontalSpace
              ],
            ),
          )),
      actions: [
        _iconActionButtonAppBar(
            icon: Icons.tune, onPressed: () => context.push(AppRoute.profile)),
        5.horizontalSpace
      ],
    );
  }

  Widget _buildSearchWidget() {
    return GestureDetector(
      onTap: () => context.push(AppRoute.search),
      child: Card(
          elevation: 1,
          color: Colors.white,
          shape: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(textFieldBorderRadius)),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppString.seachLabelText,
                    style: context.bodyMedium!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
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
