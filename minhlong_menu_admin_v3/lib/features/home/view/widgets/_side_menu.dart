part of '../screens/home_view.dart';

extension _BuildSideMenuWidget on HomeViewState {
  Widget _buildSideMenuWidget({SideMenuDisplayMode? displayMode}) => SideMenu(
        controller: _sideMenuCtrl,
        style: SideMenuStyle(
          openSideMenuWidth: context.isMobile ? null : 300.w,
          showTooltip: true,
          displayMode: displayMode ?? SideMenuDisplayMode.auto,
          hoverColor: context.colorScheme.primary.withOpacity(0.3),
          itemOuterPadding: const EdgeInsets.all(2),
          selectedColor: context.colorScheme.primary,
          selectedTitleTextStyle: context.bodyMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          unselectedTitleTextStyle: context.bodyMedium!
              .copyWith(color: context.bodyMedium!.color!.withOpacity(0.8)),
          selectedIconColor: Colors.white,
          unselectedIconColor: context.bodyMedium!.color!.withOpacity(0.5),
        ),
        title: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100.h,
                maxWidth: 100.h,
              ),
              child: Image.asset(
                AppAsset.logo,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              color: context.bodyMedium!.color!.withOpacity(0.5),
              indent: 8.0,
              endIndent: 8.0,
            ),
          ],
        ),
        items: [
          ..._listIconMenu.map((item) {
            return _buildSideMenuItem(
                title: item['title'] as String,
                icon: item['icon'] as IconData,
                onTap: (index, _) {
                  _sideMenuCtrl.changePage(index);
                  // context.go(item['route'] as String);
                });
          }),
          SideMenuItem(
            builder: (context, displayMode) {
              return Divider(
                endIndent: 8,
                indent: 8,
                color: context.bodyMedium!.color!.withOpacity(0.5),
              );
            },
          ),
          // SideMenuItem(
          //   title: 'Cài đặt',
          //   onTap: (index, _) {
          //     _sideMenuCtrl.changePage(index);
          //   },
          //   icon: const Icon(
          //     Icons.settings,
          //     color: AppColors.secondTextColor,
          //   ),
          // ),
          SideMenuItem(
            title: 'Đăng xuất',
            builder: (context, displayMode) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultPadding / 2).r,
                ),
                splashColor: context.colorScheme.primary.withOpacity(0.3),
                hoverColor: context.colorScheme.primary.withOpacity(0.3),
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: context.isDesktop
                    ? Text(
                        'Đăng xuất',
                        style: context.bodyMedium!.copyWith(
                            color: context.bodyMedium!.color!.withOpacity(0.5)),
                      )
                    : 1.horizontalSpace,
                onTap: () => _showDialogLogout(),
              );
            },
          ),
        ],
        footer: context.sizeDevice.height < 700
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(indent: 8.0, endIndent: 8.0),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Minh Long Technology',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '079.99.09.487',
                            style: context.bodyMedium!.copyWith(
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Tổ 21 Finom - Hiệp Thạnh - Đức Trọng - Lâm Đồng',
                            textAlign: TextAlign.center,
                            style: context.bodyMedium!.copyWith(
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );

  SideMenuItem _buildSideMenuItem({
    required String title,
    required IconData icon,
    required Function(int, SideMenuController)? onTap,
  }) {
    return SideMenuItem(
      title: title,
      onTap: onTap,
      icon: Icon(
        icon,
        color: context.bodyMedium!.color!.withOpacity(0.5),
      ),
      tooltipContent: title,
    );
  }
}
