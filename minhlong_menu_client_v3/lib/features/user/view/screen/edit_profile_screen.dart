import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/common/snackbar/app_snackbar.dart';
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
  final TextEditingController _subPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _imageFile = ValueNotifier(File(''));
  var _imageUrl = '';
  final _loading = ValueNotifier(0.0);

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _imageFile.dispose();
    _phoneController.dispose();
    _loading.dispose();
    _subPhoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _userModel = widget.userModel;
    _nameController.text = _userModel.fullName;
    _phoneController.text = '0${_userModel.phoneNumber}';
    _subPhoneController.text =
        _userModel.subPhoneNumber == 0 ? '' : '0${_userModel.subPhoneNumber}';
    _imageUrl = _userModel.image;
    _emailController.text = _userModel.email;
    _addressController.text = _userModel.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppString.editProfile,
          style: context.titleStyleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  msg: 'Cập nhật thành công',
                  type: AppSnackbarType.success);
              context.read<UserCubit>().userChanged(_userModel);

              break;
            case UserUpdateFailure():
              pop(context, 1);
              AppSnackbar.showSnackBar(context,
                  msg: state.errorMessage, type: AppSnackbarType.error);

              break;
            default:
          }
        },
        child: ListView(
          children: [
            20.verticalSpace,
            _imageEditProfileWidget(),
            _bodyEditInfoUser()
          ],
        ),
      ),
    );
  }

  void _updateUser(UserModel user) {
    context.read<UserBloc>().add(UserUpdated(_userModel));
  }
}
