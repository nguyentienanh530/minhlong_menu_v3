import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_item_food.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_client_v3/common/widget/grid_item_food.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/bloc/food_bloc.dart';
import 'package:minhlong_menu_client_v3/features/food/cubit/item_size_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../banner/bloc/banner_bloc.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/model/category_model.dart';

part '../widgets/_appbar_widget.dart';
part '../widgets/_banner_widget.dart';
part '../widgets/_category_widget.dart';
part '../widgets/_news_food_widget.dart';
part '../widgets/_popular_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchText = TextEditingController();
  final _indexPage = ValueNotifier(0);
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _indexPage.dispose();
    _searchText.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _isScrolledNotifier.dispose();
  }

  void _scrollListener() {
    // print("Scroll Offset: ${_scrollController.offset}"); // Debugging line
    if (_scrollController.hasClients && _scrollController.offset > 0) {
      if (!_isScrolledNotifier.value) {
        _isScrolledNotifier.value = true;
      }
    } else {
      if (_isScrolledNotifier.value) {
        _isScrolledNotifier.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            forceElevated: true,
            expandedHeight: context.isPortrait == true
                ? 0.3 * context.sizeDevice.height
                : 0.4 * context.sizeDevice.height,
            stretch: true,
            pinned: true,
            backgroundColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _bannerHome(),
            ),
            title: _seachBox(),
            actions: [
              _iconActionButtonAppBar(
                icon: Icons.table_bar_outlined,
                onPressed: () => context.push(AppRoute.dinnerTables),
              ),
              _iconActionButtonAppBar(
                  icon: Icons.tune,
                  onPressed: () => context.push(AppRoute.profile)),
              5.horizontalSpace
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                30.verticalSpace,
                categoryListView(),
                10.verticalSpace,
                _buildListNewFood(),
                20.verticalSpace,
                _popularGridView(),
                // Text("Scroll Offset: ${_scrollController.offset}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
