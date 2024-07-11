import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
// part '../widgets/_body_banner_widget.dart';
part '../widgets/_header_banner_widget.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BannerView();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _headerBannerWidget,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
