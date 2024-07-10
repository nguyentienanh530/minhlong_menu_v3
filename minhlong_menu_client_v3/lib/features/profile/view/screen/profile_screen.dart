import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../../../core/app_string.dart';

part '../widget/_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: Text(AppString.profile),
            expandedHeight: context.isPortrait
                ? 0.4 * context.sizeDevice.height
                : 0.4 * context.sizeDevice.width,
            flexibleSpace: const FlexibleSpaceBar(),
          ),
        ],
      ),
    );
  }
}
