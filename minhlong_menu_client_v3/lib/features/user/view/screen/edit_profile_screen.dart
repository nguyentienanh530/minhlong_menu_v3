import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/common/snackbar/app_snackbar.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_client_v3/features/user/data/repositories/user_repository.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';
import '../../bloc/user_bloc.dart';
import '../../data/model/user_model.dart';

part '../widget/_edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(userRepository: context.read<UserRepository>()),
      child: EditProfileView(userModel: userModel),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UserModel _userModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _imageFile = ValueNotifier(File(''));
  var _imageUrl = '';
  final _loading = ValueNotifier(0.0);
  var _isUpdated = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _imageFile.dispose();
    _phoneController.dispose();
    _loading.dispose();
  }

  @override
  void initState() {
    super.initState();
    _userModel = widget.userModel;
    _nameController.text = _userModel.fullName;
    _phoneController.text = '0${_userModel.phoneNumber}';
    _imageUrl = _userModel.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CommonBackButton(onTap: () => context.pop(_isUpdated)),
        centerTitle: true,
        title: Text(
          AppString.editProfile,
          style: context.titleStyleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          switch (state) {
            case UserUpdateInProgress():
              AppDialog.showLoadingDialog(context);
              break;
            case UserUpdateSuccess():
              pop(context, 1);
              AppSnackbar.showSnackBar(context,
                  msg: 'Cập nhật thành công', isSuccess: true);
              context.read<UserCubit>().userChanged(_userModel);
              _isUpdated = true;
              break;
            case UserUpdateFailure():
              pop(context, 1);
              AppSnackbar.showSnackBar(context,
                  msg: state.errorMessage, isSuccess: false);
              _isUpdated = false;
              break;
            default:
          }
        },
        child: Column(
          children: [
            20.verticalSpace,
            _imageEditProfileWidget(),
            Expanded(child: _bodyEditInfoUser())
          ],
        ),
      ),
    );
  }

  void _updateUser(UserModel user) {
    context.read<UserBloc>().add(UserUpdated(_userModel));
  }
}
