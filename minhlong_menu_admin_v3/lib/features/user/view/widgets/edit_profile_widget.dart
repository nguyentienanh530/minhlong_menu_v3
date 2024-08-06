import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/user/bloc/user_bloc.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _imageFile = ValueNotifier(File(''));
  late String _image;
  final _loading = ValueNotifier(0.0);
  var _isUpdated = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nameController.text = _user.fullName;
    _emailController.text = _user.fullName;
    _subPhoneController.text = '0${_user.phoneNumber.toString()}';
    _addressController.text = '0${_user.phoneNumber.toString()}';
    _phoneController.text = '0${_user.phoneNumber.toString()}';
    _image = _user.image;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subPhoneController.dispose();
    _addressController.dispose();
    _imageFile.dispose();
    _loading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Cập nhật thông tin', style: context.titleStyleLarge),
        backgroundColor: Colors.transparent,
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
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
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
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54, width: 6),
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
                                  placeholder: (context, url) =>
                                      const Loading(),
                                  fit: BoxFit.cover,
                                )
                              : Image.file(_imageFile.value, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          bottom: context.sizeDevice.height * 0.01,
                          right: context.sizeDevice.height * 0.03,
                          child: _uploadImage())
                    ],
                  );
                },
              ),
              10.verticalSpace,
              _bodyEditInfoUser(),
            ],
          ),
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
        color: context.colorScheme.primary,
        shape: const CircleBorder(),
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.camera_enhance,
            size: 16,
            color: Colors.white,
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
            20.verticalSpace,
            _buildEmailFieldWidget(),
            20.verticalSpace,
            _buildSubPhoneFieldWidget(),
            20.verticalSpace,
            _buildAdressFieldWidget(),
            30.verticalSpace,
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
      prefixIcon: Icon(Icons.person,
          color: context.bodyMedium!.color!.withOpacity(0.4)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập tên';
        }
        return null;
      },
      labelStyle: context.bodyMedium!
          .copyWith(color: context.titleStyleMedium!.color!.withOpacity(0.5)),
      hintStyle: context.bodyMedium,
      style: context.bodyMedium,
    );
  }

  Widget _buildPhoneTextField() {
    return CommonTextField(
      onChanged: (p0) {},
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Icon(Icons.phone_android_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.4)),
      validator: (p0) {
        return AppRes.validatePhoneNumber(_phoneController.text)
            ? null
            : 'Vui lòng nhập số điện thoại';
      },
      controller: _phoneController,
      labelText: AppString.phoneNumber,
      labelStyle: context.bodyMedium!
          .copyWith(color: context.titleStyleMedium!.color!.withOpacity(0.5)),
      hintStyle: context.bodyMedium,
      style: context.bodyMedium,
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
          style: context.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEmailFieldWidget() {
    return CommonTextField(
      onChanged: (p0) {},
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Icon(Icons.email_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.4)),
      validator: (p0) {
        return AppRes.validatePassword(_emailController.text)
            ? null
            : 'Vui lòng nhập địa chỉ Email';
      },
      controller: _emailController,
      labelText: AppString.email,
      labelStyle: context.bodyMedium!
          .copyWith(color: context.titleStyleMedium!.color!.withOpacity(0.5)),
      hintStyle: context.bodyMedium,
      style: context.bodyMedium,
    );
  }

  Widget _buildSubPhoneFieldWidget() {
    return CommonTextField(
      onChanged: (p0) {},
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Icon(Icons.phone_android_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.4)),
      validator: (p0) {
        return AppRes.validatePhoneNumber(_subPhoneController.text)
            ? null
            : 'Vui lòng nhập số điện thoại phụ';
      },
      controller: _subPhoneController,
      labelText: AppString.subPhoneNumber,
      labelStyle: context.bodyMedium!
          .copyWith(color: context.titleStyleMedium!.color!.withOpacity(0.5)),
      hintStyle: context.bodyMedium,
      style: context.bodyMedium,
    );
  }

  Widget _buildAdressFieldWidget() {
    return CommonTextField(
      onChanged: (p0) {},
      keyboardType: TextInputType.streetAddress,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Icon(Icons.location_on_outlined,
          color: context.bodyMedium!.color!.withOpacity(0.4)),
      validator: (p0) {
        return AppRes.validatePhoneNumber(_subPhoneController.text)
            ? null
            : 'Vui lòng nhập số điện thoại phụ';
      },
      controller: _subPhoneController,
      labelText: AppString.adress,
      labelStyle: context.bodyMedium!
          .copyWith(color: context.titleStyleMedium!.color!.withOpacity(0.5)),
      hintStyle: context.bodyMedium,
      style: context.bodyMedium,
    );
  }

  void _updateUser(UserModel user) {
    context.read<UserBloc>().add(UserUpdated(_user));
  }
}
