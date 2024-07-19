part of '../screen/edit_profile_screen.dart';

extension _EditProfileWidget on _EditProfileViewState {
  Widget _imageEditProfileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
                padding: const EdgeInsets.all(2),
                width: 0.25 * context.sizeDevice.height,
                height: 0.25 * context.sizeDevice.height,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.smokeWhite, width: 6),
                ),
                child: ValueListenableBuilder(
                  valueListenable: _imageFile,
                  builder: (context, _, __) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _imageFile.value.path.isEmpty
                          ? CachedNetworkImage(
                              imageUrl: '${ApiConfig.host}$_imageUrl',
                              errorWidget: errorBuilderForImage,
                              placeholder: (context, url) => const Loading(),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _imageFile.value,
                              fit: BoxFit.cover,
                            ),
                    );
                  },
                )),
            Positioned(
              bottom: 10,
              right: 35,
              child: _uploadImage(),
            )
          ],
        ),
        10.verticalSpace,
      ],
    );
  }

  Widget _uploadImage() {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () async => Ultils.pickImage().then((value) {
        if (value != null) {
          _imageFile.value = value;
        }
      }),
      child: Card(
        shape: const CircleBorder(),
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.photo_camera,
            size: 20,
            color: AppColors.secondTextColor,
          ),
        ),
      ),
    );
  }

  Widget _bodyEditInfoUser() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shadowColor: AppColors.lavender,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultBorderRadius * 2),
          topRight: Radius.circular(defaultBorderRadius * 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding * 2),
        child: Form(
          key: AppKeys.updateUserKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBoxProfile(
                  controllers: _nameController,
                  labelText: AppString.fullName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên';
                    }
                    return null;
                  }),
              20.verticalSpace,
              TextBoxProfile(
                  controllers: _phoneController,
                  labelText: '${AppString.phoneNumber} *',
                  validator: (value) {
                    return AppRes.validatePhoneNumber(_phoneController.text)
                        ? null
                        : 'Vui lòng nhập số điện thoại';
                  }),
              20.verticalSpace,
              _buttonEditProfile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonEditProfile() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.themeColor),
          onPressed: () async {
            if (AppKeys.updateUserKey.currentState!.validate()) {
              if (_imageFile.value.path.isNotEmpty) {
                _imageUrl = await Ultils.uploadImage(
                        file: _imageFile.value,
                        path: 'users',
                        loading: _loading) ??
                    '';
              }
              _userModel = _userModel.copyWith(
                fullName: _nameController.text,
                phoneNumber: int.parse(_phoneController.text),
                image: _imageUrl,
              );
              _updateUser(_userModel);
            }
          },
          child: Text(
            AppString.edit,
            style: kBodyWhiteStyle,
          )),
    );
  }
}

class TextBoxProfile extends StatelessWidget {
  const TextBoxProfile({
    super.key,
    required this.controllers,
    this.labelText,
    this.validator,
  });
  final TextEditingController controllers;
  final String? labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (p0) {},
      labelText: labelText,
      labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      controller: controllers,
      style: kBodyStyle,
      validator: validator,
    );
  }
}
