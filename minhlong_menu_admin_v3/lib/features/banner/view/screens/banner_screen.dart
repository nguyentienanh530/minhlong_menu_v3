import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/banner/bloc/banner_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_item.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_model.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/repositories/banner_repository.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/network/dio_client.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../common/widget/number_pagination.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../order/cubit/pagination_cubit.dart';
import '../../data/provider/banner_api.dart';
import '../dialogs/create_or_update_banner.dart';
part '../widgets/_body_banner_widget.dart';
part '../widgets/_header_banner_widget.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BannerBloc(bannerRepository: context.read<BannerRepository>()),
        ),
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
      ],
      child: const BannerView(),
    );
  }
}

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView>
    with AutomaticKeepAliveClientMixin {
  final _limit = ValueNotifier(10);
  final _curentPage = ValueNotifier(1);
  final _bannerValueNotifier = ValueNotifier(BannerModel());
  final _listTitleTable = ['Hình ảnh', 'Tên', 'Trạng thái', 'Hành động'];

  @override
  void initState() {
    super.initState();
    _fechData(page: _curentPage.value, limit: _limit.value);
  }

  @override
  void dispose() {
    super.dispose();
    _limit.dispose();
    _curentPage.dispose();
    _bannerValueNotifier.dispose();
  }

  void _fechData({required int page, required int limit}) {
    BlocProvider.of<BannerBloc>(context).add(
      BannerFetched(page: page, limit: limit, type: 'paging'),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _headerBannerWidget,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: _bodyBannerWidget(),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
