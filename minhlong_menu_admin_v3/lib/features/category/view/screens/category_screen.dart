import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/category/bloc/category_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_item.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_model.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/repositories/category_repository.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../order/cubit/pagination_cubit.dart';
import '../dialogs/create_or_update_category.dart';

part '../widgets/_header_category_widget.dart';
part '../widgets/_body_category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>()),
        ),
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
      ],
      child: const CategoryView(),
    );
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with AutomaticKeepAliveClientMixin {
  final _limit = ValueNotifier(10);
  final _curentPage = ValueNotifier(1);
  final _categoryValueNotifier = ValueNotifier(CategoryModel());
  final _listTitleTable = ['Hình ảnh', 'Tên', 'Thứ tự hiển thị', 'Hành động'];

  @override
  void initState() {
    super.initState();
    _fetchCategory(limit: _limit.value, page: _curentPage.value);
  }

  void _fetchCategory({required int limit, required int page}) {
    context.read<CategoryBloc>().add(CategoryFetched(
        limit: _limit.value, page: _curentPage.value, type: 'paging'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _headerCategoryWidget,
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(20).r,
                child: _bodyCategoryWidget())),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
