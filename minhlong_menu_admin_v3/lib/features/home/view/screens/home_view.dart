import 'dart:convert';
import 'dart:developer';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/order_socket_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/web_socket_client/cubit/web_socket_client_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/error_dialog.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../dinner_table/cubit/dinner_table_cubit.dart';
import '../../../dinner_table/data/model/table_model.dart';
import '../../../order/data/model/order_model.dart';
part '../widgets/side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.child, required this.index});
  final Widget child;
  final int index;

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // final PageController _pageCtrl = PageController();

  final SideMenuController _sideMenuCtrl = SideMenuController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(ApiConfig.webSocketUrl),
  );

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

    _channel.ready.then((value) {
      context.read<WebSocketClientCubit>().init(_channel);
      _handleDataSocket(widget.index);

      context.read<WebSocketClientCubit>().send('tables', 0);
      context.read<WebSocketClientCubit>().send('orders', 0);
    });
    _sideMenuCtrl.addListener((index) {
      // _pageCtrl.jumpToPage(index);
      _title.value = _listIconMenu[index]['title'].toString();
    });
    super.initState();
  }

  void _handleDataSocket(int tableIndexSelected) {
    _channel.stream.listen(
      (event) {
        Map<String, dynamic> data = jsonDecode(event);

        switch (data['event']) {
          case 'tables-ws':
            var res = jsonDecode(data['payload']);
            context.read<DinnerTableCubit>().setTableList(
                List<TableModel>.from(res.map((x) => TableModel.fromJson(x))));

            break;
          case 'orders-ws':
            var res = jsonDecode(data['payload']);

            var orderList = <OrderModel>[];
            var orders =
                List<OrderModel>.from(res.map((x) => OrderModel.fromJson(x)));

            if (tableIndexSelected != 0) {
              for (var order in orders) {
                if (order.tableId == tableIndexSelected) {
                  orderList.add(order);
                }
              }
            } else {
              orderList = orders;
            }
            context.read<OrderSocketCubit>().setOrderList(orderList);
            break;
          default:
            log('event: $event');
            break;
        }
      },
      onDone: () {
        log('Connection closed');
      },
      onError: (error) {
        log('Error: $error');
      },
    );

    // if (!mounted) return;
  }

  @override
  void dispose() {
    // _pageCtrl.dispose();
    _sideMenuCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ResponsiveBreakpoints.of(context).isMobile
        ? _buildMobileScreen()
        : _buildDesktopWidget();
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
            _buildSideMenuWidget(),
            Expanded(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(child: widget.child),
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
              child: widget.child,
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
      toolbarHeight: ResponsiveBreakpoints.of(context).isMobile ? null : 115,
      title: ValueListenableBuilder(
          valueListenable: _title,
          builder: (context, value, child) {
            return Text(value,
                style: kHeadingStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize:
                        ResponsiveBreakpoints.of(context).isMobile ? 24 : 36));
          }),
      actions: ResponsiveBreakpoints.of(context).isMobile
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
