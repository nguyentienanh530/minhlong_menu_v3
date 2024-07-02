part of '../screens/home_view.dart';

extension _BuildSideMenuWidget on HomeViewState {
  Widget _buildSideMenuWidget({SideMenuDisplayMode? displayMode}) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: _sideMenuCtrl,
            style: SideMenuStyle(
              showTooltip: true,
              displayMode: displayMode ?? SideMenuDisplayMode.auto,
              // showHamburger: true,
              backgroundColor: AppColors.white,
              hoverColor: AppColors.themeColor.withOpacity(0.3),
              itemOuterPadding: const EdgeInsets.all(2),

              selectedColor: AppColors.themeColor,
              selectedTitleTextStyle: kBodyStyle.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
              unselectedTitleTextStyle:
                  kBodyStyle.copyWith(color: AppColors.secondTextColor),
              selectedIconColor: Colors.white,
              unselectedIconColor: AppColors.secondTextColor,
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.grey[200]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 134,
                    maxWidth: 200,
                  ),
                  child: Image.asset(
                    AppAsset.logo,
                    fit: BoxFit.cover,
                  ),
                ),
                const Divider(
                  color: AppColors.secondTextColor,
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
                      context.go(item['route'] as String);
                    });
              }),
              SideMenuItem(
                builder: (context, displayMode) {
                  return const Divider(
                    endIndent: 8,
                    indent: 8,
                    color: AppColors.secondTextColor,
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
                icon: const Icon(
                  Icons.exit_to_app,
                  color: AppColors.secondTextColor,
                ),
                onTap: (index, _) {
                  _showDialogLogout();
                },
              ),
            ],
            footer: Padding(
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
                          style: kSubHeadingStyle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '079.99.09.487',
                          style: kBodyStyle.copyWith(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w700,
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
                          style: kCaptionStyle.copyWith(
                            color: AppColors.secondTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  SideMenuItem _buildSideMenuItem({
    required String title,
    required IconData icon,
    required Function(int, SideMenuController)? onTap,
  }) {
    return SideMenuItem(
      title: title,
      onTap: onTap,
      icon: Icon(icon, color: AppColors.secondTextColor),
      tooltipContent: title,
    );
  }
}
