import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/Routes/app_route.dart';
import 'package:minhlong_menu_admin_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/best_selling_food/best_selling_food_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/daily_revenue/daily_revenue_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/data_chart/data_chart_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/info/info_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
import 'package:minhlong_menu_admin_v3/features/home/cubit/table_index_selected_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/repositories/order_repository.dart';
import 'package:minhlong_menu_admin_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/data/auth_local_datasource/auth_local_datasource.dart';
import '../../../dinner_table/cubit/dinner_table_cubit.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../user/bloc/user_bloc.dart';
import '../../data/model/data_chart.dart';
import '../widgets/_bar_chart_revenue.dart';
import '../widgets/indicator.dart';
import '../widgets/line_chart_revenue.dart';
import '../widgets/pie_chart_top4_best_selling.dart';

part '../widgets/_info_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableIndexSelectedCubit(),
        ),
        BlocProvider(
          create: (context) => DinnerTableCubit(),
        ),
        BlocProvider(
          create: (context) => InfoBloc(
            context.read<InfoRespository>(),
          ),
        ),
        BlocProvider(
          create: (context) => BestSellingFoodBloc(
            infoRespository: context.read<InfoRespository>(),
          ),
        ),
        BlocProvider(
          create: (context) => DataChartBloc(
            infoRespository: context.read<InfoRespository>(),
          ),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            context.read<OrderRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => DailyRevenueBloc(
            context.read<InfoRespository>(),
          ),
        )
      ],
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is UserFecthFailure) {
            context.read<UserCubit>().userChanged(UserModel());
            await AuthLocalDatasource(await SharedPreferences.getInstance())
                .removeAccessToken();
            if (!context.mounted) return;
            context.read<AuthBloc>().add(AuthAuthenticateStarted());
            context.go(AppRoute.login);
          }
        },
        builder: (context, state) {
          return (switch (state) {
            UserFecthSuccess() => DashboardView(user: state.user),
            UserFecthFailure() => ErrWidget(error: state.errorMessage),
            UserFecthInProgress() => const Loading(),
            _ => Container(),
          });
        },
      ),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.user});
  final UserModel user;
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with AutomaticKeepAliveClientMixin {
  final _listDateDropdown = ['Tuần này', 'Tháng này', 'Năm nay'];
  final _valueDropdown = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().userChanged(widget.user);
    context.read<InfoBloc>().add(InfoFetchStarted());
    context.read<BestSellingFoodBloc>().add(BestSellingFoodFetched());
    context.read<DataChartBloc>().add(DataChartFetched('week'));
    context.read<DailyRevenueBloc>().add(DailyRevenueFetched());
    _valueDropdown.value = _listDateDropdown.first;
  }

  void _onRefreshDataDashboard() {
    context.read<InfoBloc>().add(InfoFetchStarted());
    context.read<BestSellingFoodBloc>().add(BestSellingFoodFetched());
    context.read<DailyRevenueBloc>().add(DailyRevenueFetched());
    context
        .read<DataChartBloc>()
        .add(DataChartFetched(_handleTypeChart(_valueDropdown.value)));
  }

  String _handleTypeChart(String type) {
    if (type == 'Tuần này') {
      return 'week';
    } else if (type == 'Tháng này') {
      return 'month';
    } else {
      return 'year';
    }
  }

  @override
  void dispose() {
    super.dispose();

    _valueDropdown.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(30).r,
      child: RefreshIndicator(
        onRefresh: () async {
          _onRefreshDataDashboard();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: _buildInfoWidget(),
              ),
              15.verticalSpace,
              context.isDesktop
                  ? SizedBox(
                      height: 0.5 * context.sizeDevice.height,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _barChartRevenueWidget(),
                          ),
                          15.horizontalSpace,
                          Expanded(
                            child: _chartBestSellingFoodWidget(),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                            height: 0.5 * context.sizeDevice.height,
                            child: _barChartRevenueWidget()),
                        15.horizontalSpace,
                        SizedBox(
                            height: 0.5 * context.sizeDevice.height,
                            child: _chartBestSellingFoodWidget())
                      ],
                    ),
              15.verticalSpace,
              SizedBox(
                  height: 0.5 * context.sizeDevice.height,
                  child: _chartStatisticalWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget _barChartRevenueWidget() {
    return Card(
      elevation: 1,
      shadowColor: context.colorScheme.onPrimary.withOpacity(0.5),
      child: Builder(builder: (context) {
        var dataChartState = context.watch<DataChartBloc>().state;
        return (switch (dataChartState) {
          DataChartFetchInProgress() => const Loading(),
          DataChartFetchEmpty() => const EmptyWidget(),
          DataChartFetchFailure() => ErrWidget(error: dataChartState.message),
          DataChartFetchSuccess() =>
            _buildChartRevenueFetchSuccess(dataChartState.dataCharts),
          _ => const SizedBox(),
        });
      }),
    );
  }

  Widget _buildChartRevenueFetchSuccess(List<DataChart> dataCharts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Doanh thu',
                  style: context.titleStyleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListenableBuilder(
                  listenable: _valueDropdown,
                  builder: (context, _) {
                    return DropdownButton(
                      items: _listDateDropdown
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        switch (value) {
                          case 'Tuần này':
                            context
                                .read<DataChartBloc>()
                                .add(DataChartFetched('week'));
                            break;
                          case 'Tháng này':
                            context
                                .read<DataChartBloc>()
                                .add(DataChartFetched('month'));
                            break;
                          case 'Năm nay':
                            context
                                .read<DataChartBloc>()
                                .add(DataChartFetched('year'));
                            break;
                          default:
                            break;
                        }
                        _valueDropdown.value = value!;
                      },
                      isDense: true,
                      underline: Container(),
                      value: _valueDropdown.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      style: context.bodyMedium,
                      borderRadius: BorderRadius.circular(5),
                      menuMaxHeight: 300,
                      alignment: Alignment.center,
                      iconSize: 20,
                    );
                  },
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Expanded(
            flex: 8,
            child: BarChartRevenue(
              dataCharts: dataCharts,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartBestSellingFoodWidget() {
    return Builder(builder: (context) {
      var bestSellingFoodState = context.watch<BestSellingFoodBloc>().state;
      return (switch (bestSellingFoodState) {
        BestSellingFoodFetchInProgress() => const Loading(),
        BestSellingFoodFetchEmpty() => const EmptyWidget(),
        BestSellingFoodFetchFailure() =>
          ErrWidget(error: bestSellingFoodState.message),
        BestSellingFoodFetchSuccess() => Card(
            elevation: 1,
            shadowColor: context.colorScheme.onPrimary.withOpacity(0.5),
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top 4 bán chạy',
                    style: context.titleStyleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: PieChartTop4BestSellingFood(
                      bestSellingFood: bestSellingFoodState.bestSellingFoods,
                    ),
                  ),
                ],
              ),
            ),
          ),
        _ => const SizedBox(),
      });
    });
  }

  Widget _chartStatisticalWidget() {
    return Builder(builder: (context) {
      var dailyRevenueState = context.watch<DailyRevenueBloc>().state;

      return (switch (dailyRevenueState) {
        DailyRevenueFetchInProgress() => const Loading(),
        DailyRevenueFetchEmpty() => const EmptyWidget(),
        DailyRevenueFetchFailure() =>
          ErrWidget(error: dailyRevenueState.message),
        DailyRevenueFetchSuccess() => Card(
            elevation: 1,
            shadowColor: context.colorScheme.onPrimary.withOpacity(0.5),
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thống kê (30 ngày)',
                              style: context.titleStyleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            10.verticalSpace,
                            Row(children: [
                              const Indicator(
                                color: Colors.red,
                                text: 'Tổng doanh thu',
                                isSquare: true,
                              ),
                              20.horizontalSpace,
                              const Indicator(
                                color: Colors.green,
                                text: 'Tổng đơn',
                                isSquare: true,
                              ),
                            ])
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thống kê (30 ngày)',
                              style: context.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Row(children: [
                              const Indicator(
                                color: Colors.red,
                                text: 'Tổng doanh thu',
                                isSquare: true,
                              ),
                              20.horizontalSpace,
                              const Indicator(
                                color: Colors.green,
                                text: 'Tổng đơn',
                                isSquare: true,
                              ),
                            ])
                          ],
                        ),
                  30.verticalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2),
                      child: LineChartRevenue(
                        dailyRevenues: dailyRevenueState.dailyRevenues,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        _ => const SizedBox(),
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
