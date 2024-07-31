import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/banner/view/screens/banner_screen.dart';
import 'package:minhlong_menu_admin_v3/features/category/view/screens/category_screen.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/view/screens/dashboard_screen.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/view/screens/dinner_table_screen.dart';
import 'package:minhlong_menu_admin_v3/features/food/view/screens/food_screen.dart';
import 'package:minhlong_menu_admin_v3/features/order/view/screens/order_screen.dart';
import 'package:minhlong_menu_admin_v3/features/setting/view/screens/setting_screen.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_dialog.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../order_history/view/screens/order_history_screen.dart';
import '../../../user/cubit/user_cubit.dart';

part '../widgets/_side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final PageController _pageCtrl =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  final SideMenuController _sideMenuCtrl = SideMenuController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _indexPage = ValueNotifier(0);
  final _listIconMenu = [
    {
      'title': 'Dashboard',
      'icon': Icons.home_rounded,
      'route': AppRoute.dashboard,
    },
    {
      'title': 'Đơn hàng',
      'icon': Icons.format_list_numbered,
      'route': AppRoute.orders,
    },
    {
      'title': 'Lịch sử Đơn',
      'icon': Icons.history_rounded,
      'route': AppRoute.ordersHistory,
    },
    {
      'title': 'Món ăn',
      'icon': Icons.fastfood_rounded,
      'route': AppRoute.foods,
    },
    {
      'title': 'Bàn ăn',
      'icon': Icons.dining_rounded,
      'route': AppRoute.dinnerTables,
    },
    {
      'title': 'Danh mục',
      'icon': Icons.category,
      'route': AppRoute.categories,
    },
    {
      'title': 'Banner',
      'icon': Icons.image,
      'route': AppRoute.banners,
    },
    {
      'title': 'Cài đặt',
      'icon': Icons.settings,
      'route': AppRoute.settings,
    },
  ];
  final _title = ValueNotifier('');

  @override
  void initState() {
    super.initState();

    _title.value = _listIconMenu[0]['title'].toString();
    _sideMenuCtrl.addListener((index) {
      // _pageCtrl.animateToPage(index,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _indexPage.value = index;
      _title.value = _listIconMenu[index]['title'].toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageCtrl.dispose();
    _sideMenuCtrl.dispose();
    _title.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: context.isMobile ? _buildAppBar() : null,
      key: _scaffoldKey,
      drawer: context.isMobile
          ? _buildSideMenuWidget(displayMode: SideMenuDisplayMode.open)
          : null,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state) {
                case AuthLogoutSuccess():
                  context.read<AuthBloc>().add(AuthEventStarted());
                  context.pushReplacement(AppRoute.login);

                  break;
                case AuthLogoutFailure(message: final msg):
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ErrorDialog(
                        title: msg,
                        onRetryText: 'Thử lại',
                        onRetryPressed: () {
                          context.pop();
                          context.read<AuthBloc>().add(AuthLogoutStarted());
                        },
                      );
                    },
                  );
                  break;
                default:
              }
            },
          ),
        ],
        child: Row(
          children: [
            context.isMobile
                ? const SizedBox()
                : _buildSideMenuWidget(
                    displayMode: context.isTablet
                        ? SideMenuDisplayMode.compact
                        : SideMenuDisplayMode.open),
            Expanded(
              child: Column(
                children: [
                  context.isMobile ? const SizedBox() : _buildHeader(user),
                  // Expanded(
                  //   child: ValueListenableBuilder(
                  //     valueListenable: _pageIndex,
                  //     builder: (context, value, child) => IndexedStack(
                  //       index: _pageIndex.value,
                  //       children: _listPage,
                  //     ),
                  //   ),
                  // ),

                  // Expanded(
                  //   child: PageView.builder(
                  //     itemCount: <Widget>[
                  //       DashboardScreen(userModel: user),
                  //       const OrderScreen(),
                  //       const OrderHistoryScreen(),
                  //       const FoodScreen(),
                  //       const DinnerTableScreen(),
                  //       const CategoryScreen(),
                  //       const BannerScreen(),
                  //       const SettingScreen(),
                  //     ].length,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) {
                  //       return <Widget>[
                  //         DashboardScreen(userModel: user),
                  //         const OrderScreen(),
                  //         const OrderHistoryScreen(),
                  //         const FoodScreen(),
                  //         const DinnerTableScreen(),
                  //         const CategoryScreen(),
                  //         const BannerScreen(),
                  //         const SettingScreen(),
                  //       ][index];
                  //     },
                  //     controller: _pageCtrl,
                  //   ),
                  // ),

                  Expanded(
                      child: ListenableBuilder(
                          listenable: _indexPage,
                          builder: (context, _) {
                            return switch (_indexPage.value) {
                              0 => DashboardScreen(userModel: user),
                              1 => OrderScreen(
                                  user: user,
                                ),
                              2 => const OrderHistoryScreen(),
                              3 => const FoodScreen(),
                              4 => const DinnerTableScreen(),
                              5 => const CategoryScreen(),
                              6 => const BannerScreen(),
                              7 => const SettingScreen(),
                              _ => DashboardScreen(userModel: user)
                            };
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogLogout() {
    AppDialog.showErrorDialog(
      context,
      title: 'Đăng xuất nhó?',
      description: 'Ấy có muốn đăng xuất không?',
      cancelText: 'Thôi',
      haveCancelButton: true,
      confirmText: 'Bái bai',
      onPressedComfirm: () {
        context.read<AuthBloc>().add(AuthLogoutStarted());
      },
    );
  }

  _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      toolbarHeight: context.isMobile ? null : 115.h,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.isMobile
              ? Card(
                  child: SizedBox(
                  height: 40,
                  width: 40,
                  child: InkWell(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: const Icon(Icons.menu)),
                ))
              : const SizedBox(),
          ValueListenableBuilder(
              valueListenable: _title,
              builder: (context, value, child) {
                return Text(value,
                    style: kHeadingStyle.copyWith(fontWeight: FontWeight.w900));
              }),
          const SizedBox(
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(UserModel user) {
    return _buildFechUserSuccess(user);
  }

  Widget _buildAvatar(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(3), // Border radius
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          // height: 40,
          // width: 40,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.fill,
        errorWidget: errorBuilderForImage,
        placeholder: (context, url) => const Loading(),
        height: 40,
        width: 40,
      ),
    );
  }

  _buildUserInfo(UserModel user) {
    return Row(
      children: [
        Text(
          'Xin chào! ${user.fullName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: kBodyStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        10.horizontalSpace,
        _buildAvatar('${ApiConfig.host}${user.image}'),
      ],
    );
  }

  _buildFechUserSuccess(UserModel user) {
    return SizedBox(
      height: 115.h,
      child: Row(
        children: [
          30.horizontalSpace,
          ListenableBuilder(
              listenable: _title,
              builder: (context, _) {
                return Text(
                  _title.value,
                  style: kHeadingStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                );
              }),
          const Spacer(),
          _buildUserInfo(user),
          30.horizontalSpace,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
