import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';

part '../widget/_change_password_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePassword> {
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _oldPwController = TextEditingController();
  final TextEditingController _reNewPwController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _newPwController.dispose();
    _oldPwController.dispose();
    _reNewPwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: CommonBackButton(onTap: () => context.pop()),
            title: FittedBox(
                alignment: Alignment.center,
                child: Text(AppString.changePassword)),
          ),
          SliverToBoxAdapter(child: _buildChangePasswordWidget())
        ],
      ),
    );
  }
}
