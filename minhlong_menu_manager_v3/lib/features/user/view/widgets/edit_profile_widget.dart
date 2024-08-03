import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_manager_v3/core/app_key.dart';
import 'package:minhlong_menu_manager_v3/core/extensions.dart';
import 'package:minhlong_menu_manager_v3/core/utils.dart';
import 'package:minhlong_menu_manager_v3/features/user/bloc/user_bloc.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import '../../cubit/user_cubit.dart';
import '../../data/model/user_model.dart';

class EditProfileWidget extends StatefulWidget {
  final UserModel user;
  const EditProfileWidget({super.key, required this.user});

  @override
  State<EditProfileWidget> createState() => __EditSettingWidgetState();
}

class __EditSettingWidgetState extends State<EditProfileWidget> {
  late UserModel _user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _imageFile = ValueNotifier(File(''));
  late String _image;
  final _loading = ValueNotifier(0.0);
  var _isUpdated = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameController.text = _user.fullName;
    _phoneController.text = '0${_user.phoneNumber.toString()}';
    _image = _user.image;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _imageFile.dispose();
    _loading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Cập nhật thông tin', style: kHeadingStyle),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(_isUpdated),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserUpdateInProgress) {
              AppDialog.showLoadingDialog(context,
                  isProgressed: _imageFile.value.path.isNotEmpty ? true : false,
                  progressValue: _loading.value,
                  imageName: _image);
            }
            if (state is UserUpdateSuccess) {
              context.isMobile ? pop(context, 2) : pop(context, 1);
              OverlaySnackbar.show(context, 'Thao tác thành công');
              _isUpdated = true;
              context.read<UserCubit>().userChanged(_user);
            }
            if (state is UserUpdateFailure) {
              context.isMobile ? pop(context, 2) : pop(context, 1);
              OverlaySnackbar.show(context, state.errorMessage,
                  type: OverlaySnackbarType.error);
              _isUpdated = false;
            }
          },
          child: context.isMobile
              ? _bodyWidget()
              : Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: _bodyWidget(),
                    ),
                    const Spacer(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _imageFile,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 0.25 * context.sizeDevice.height,
                      height: 0.25 * context.sizeDevice.height,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.smokeWhite, width: 6),
                      ),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: _imageFile.value.path.isEmpty
                            ? CachedNetworkImage(
                                imageUrl: '${ApiConfig.host}$_image',
                                errorWidget: errorBuilderForImage,
                                placeholder: (context, url) => const Loading(),
                                fit: BoxFit.cover,
                              )
                            : Image.file(_imageFile.value, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(bottom: 15, right: 20, child: _uploadImage())
                  ],
                );
              },
            ),
            10.verticalSpace,
            _bodyEditInfoUser(),
          ],
        ),
      ),
    );
  }

  Widget _uploadImage() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () async => Ultils.pickImage().then((value) {
        if (value != null) {
          _imageFile.value = value;
        }
      }),
      child: Card(
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.camera_enhance,
            size: 16,
            color: AppColors.secondTextColor,
          ),
        ),
      ),
    );
  }

  Widget _bodyEditInfoUser() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Form(
        key: AppKeys.updateUserKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserNameTextField(),
            20.verticalSpace,
            _buildPhoneTextField(),
            10.verticalSpace,
            20.verticalSpace,
            _buttonEditProfile(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNameTextField() {
    return CommonTextField(
      onChanged: (p0) {},
      controller: _nameController,
      labelText: AppString.fullName,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập tên';
        }
        return null;
      },
      labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      hintStyle: kBodyStyle,
      style: kBodyStyle,
    );
  }

  Widget _buildPhoneTextField() {
    return CommonTextField(
      onChanged: (p0) {},
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (p0) {
        return AppRes.validatePhoneNumber(_phoneController.text)
            ? null
            : 'Vui lòng nhập số điện thoại';
      },
      controller: _phoneController,
      labelText: AppString.phoneNumber,
      labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      hintStyle: kBodyStyle,
      style: kBodyStyle,
    );
  }

  Widget _buttonEditProfile() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary),
        onPressed: () async {
          if (AppKeys.updateUserKey.currentState!.validate()) {
            if (_imageFile.value.path.isNotEmpty) {
              _image = await Ultils.uploadImage(
                      file: _imageFile.value,
                      path: 'users',
                      loading: _loading) ??
                  '';
            }
            _user = _user.copyWith(
              fullName: _nameController.text,
              phoneNumber: int.parse(_phoneController.text),
              image: _image,
            );
            _updateUser(_user);
          }
        },
        child: Text(
          AppString.edit,
          style: kBodyWhiteStyle,
        ),
      ),
    );
  }

  void _updateUser(UserModel user) {
    context.read<UserBloc>().add(UserUpdated(_user));
  }
}
