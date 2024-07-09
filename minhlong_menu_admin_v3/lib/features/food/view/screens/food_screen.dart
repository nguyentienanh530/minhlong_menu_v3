import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/food/bloc/food_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_item.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/provider/food_api.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';
import '../../../order/cubit/pagination_cubit.dart';
import '../../data/repositories/food_repository.dart';
import '../dialogs/create_or_update_food_dialog.dart';

part '../widgets/_food_header_widget.dart';
part '../widgets/_food_body_widget.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FoodRepository(FoodApi(DioClient().dio!)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FoodBloc(context.read<FoodRepository>())
              ..add(FoodFetched(page: 1, limit: 10)),
          ),
          BlocProvider(
            create: (context) => PaginationCubit(),
          ),
        ],
        child: const FoodView(),
      ),
    );
  }
}

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  final _listTitleTable = [
    'Hình ảnh',
    'Tên món ăn',
    'Danh mục',
    'Giá bán',
    'Giảm giá(%)',
    'Ẩn/Hiện thị',
    'Hành động'
  ];
  final _curentPage = ValueNotifier(1);
  final _limit = ValueNotifier(10);
  final _foodModel = ValueNotifier(FoodModel());

  void _fetchData({required int page, required int limit}) {
    context.read<FoodBloc>().add(FoodFetched(page: page, limit: limit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: Column(
          children: [
            _foodHeaderWidget,
            20.verticalSpace,
            Expanded(child: _foodBodyWidget())
          ],
        ),
      ),
    );
  }
}
