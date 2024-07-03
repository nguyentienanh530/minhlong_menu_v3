import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/banner/view/screens/banner_screen.dart';
import 'package:minhlong_menu_admin_v3/features/category/view/screens/category_screen.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/view/screens/dashboard_screen.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/view/screens/dinner_table_screen.dart';
import 'package:minhlong_menu_admin_v3/features/food/view/screens/food_screen.dart';
import 'package:minhlong_menu_admin_v3/features/order/view/screens/order_screen.dart';
import 'package:minhlong_menu_admin_v3/features/setting/view/screens/setting_screen.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/error_dialog.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../auth/bloc/auth_bloc.dart';
part '../widgets/side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final PageController _pageCtrl = PageController();

  final SideMenuController _sideMenuCtrl = SideMenuController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageIndex = ValueNotifier(0);

  final _listPage = <Widget>[
    const DashboardScreen(),
    const OrderScreen(),
    const FoodScreen(),
    const DinnerTableScreen(),
    const CategoryScreen(),
    const BannerScreen(),
    const SettingScreen(),
  ];

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
    }
  ];
  final _title = ValueNotifier('');

  @override
  void initState() {
    _title.value = _listIconMenu[0]['title'].toString();
    _sideMenuCtrl.addListener((index) {
      _pageIndex.value = index;
      // _pageCtrl.animateToPage(index,
      //     duration: const Duration(milliseconds: 300),
      // curve: Curves.easeInBack);
      _pageCtrl.jumpToPage(index);
      _title.value = _listIconMenu[index]['title'].toString();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _sideMenuCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildDesktopWidget();
  }

  Scaffold _buildDesktopWidget() {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
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
        child: Row(
          children: [
            context.isMobile ? const SizedBox() : _buildSideMenuWidget(),
            Expanded(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                      child: ValueListenableBuilder(
                    valueListenable: _pageIndex,
                    builder: (context, value, child) => IndexedStack(
                      index: _pageIndex.value,
                      children: _listPage,
                    ),
                  )
                      // PageView(controller: _pageCtrl, children: _listPage)
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AppDialog(
            title: 'Đăng xuất?',
            description: 'Bạn có muốn đăng xuất?',
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutStarted());
            },
          );
        });
  }

  _buildMobileScreen() {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSideMenuWidget(displayMode: SideMenuDisplayMode.open),
      appBar: _buildAppBar(),

      //  AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu),
      //     onPressed: () {
      //       _scaffoldKey.currentState!.openDrawer();
      //     },
      //   ),
      // ),
      body: BlocListener<AuthBloc, AuthState>(
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
        child: Row(
          children: [
            Expanded(
              child: PageView(controller: _pageCtrl, children: _listPage),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.background,
      toolbarHeight: context.isMobile ? null : 115,
      leading: context.isMobile
          ? Container(
              constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
              child: const Card(child: Icon(Icons.menu)))
          : null,
      title: ValueListenableBuilder(
          valueListenable: _title,
          builder: (context, value, child) {
            return Text(value,
                style: kHeadingStyle.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 36.sp));
          }),
      actions: context.isMobile
          ? [
              _buildAvatar(),
              const SizedBox(
                width: defaultPadding,
              ),
            ]
          : [
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Xin chèo, Nguyen Tien Anh',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSubHeadingStyle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              _buildAvatar(),
              const SizedBox(
                width: defaultPadding,
              ),
            ],
    );
  }

  Widget _buildAvatar() {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        constraints: const BoxConstraints(
          maxHeight: 45,
          maxWidth: 45,
        ),
        decoration:
            const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(AppAsset.logo),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
