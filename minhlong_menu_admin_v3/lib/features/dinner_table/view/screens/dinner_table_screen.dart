import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_model.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/view/dialogs/create_or_update_dinner_table_dialog.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../common/widget/number_pagination.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/app_style.dart';
import '../../../order/cubit/pagination_cubit.dart';
import '../../bloc/dinner_table_bloc.dart';
import '../../data/model/table_item.dart';
import '../../data/repositories/table_repository.dart';
part '../widgets/_header_dinner_table.dart';
part '../widgets/_body_dinner_table.dart';

class DinnerTableScreen extends StatelessWidget {
  const DinnerTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DinnerTableBloc(context.read<DinnerTableRepository>()),
        ),
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
      ],
      child: const DinnerTableView(),
    );
  }
}

class DinnerTableView extends StatefulWidget {
  const DinnerTableView({super.key});

  @override
  State<DinnerTableView> createState() => _DinnerTableViewState();
}

class _DinnerTableViewState extends State<DinnerTableView>
    with AutomaticKeepAliveClientMixin {
  final _limit = ValueNotifier(10);
  final _curentPage = ValueNotifier(1);
  final _dinnerTableValueNotifier = ValueNotifier(TableModel());

  final _listTitleTable = [
    'ID',
    'Tên bàn',
    'Số ghế',
    'Trạng thái',
    'Hành động'
  ];

  @override
  void initState() {
    super.initState();
    _fetchDateDinnerTable(limit: _limit.value, page: _curentPage.value);
  }

  @override
  void dispose() {
    super.dispose();
    _limit.dispose();
    _curentPage.dispose();
    _dinnerTableValueNotifier.dispose();
  }

  void _fetchDateDinnerTable({required int limit, required int page}) {
    context
        .read<DinnerTableBloc>()
        .add(DinnerTableFetched(limit: limit, page: page));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _headerDinnerTableWidget,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _bodyDinnerTableWidget(),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
