part of '../screen/edit_profile_screen.dart';

extension _EditProfileWidget on _EditProfileScreenState {
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
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: _userList[0].image!,
                  errorWidget: errorBuilderForImage,
                  placeholder: (context, url) => const Loading(),
                ),
              ),
            ),
            Positioned(bottom: 10, right: 10, child: _uploadImage())
          ],
        ),
        10.verticalSpace,
      ],
    );
  }

  Widget _uploadImage() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {},
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
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textProfile(AppString.fullName),
          TextBoxProfile(controllers: _nameController),
          10.verticalSpace,
          _textProfile(AppString.phoneNumber),
          TextBoxProfile(controllers: _phoneController),
          20.verticalSpace,
          _buttonEditProfile(),
        ],
      ),
    );
  }

  Widget _buttonEditProfile() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.themeColor),
          onPressed: () {},
          child: Text(
            AppString.edit,
            style: kBodyWhiteStyle,
          )),
    );
  }

  Widget _textProfile(String stringText) {
    return Text(stringText,
        style: kBodyStyle.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.secondTextColor));
  }
}

// ignore: must_be_immutable
class TextBoxProfile extends StatelessWidget {
  TextBoxProfile({
    super.key,
    required this.controllers,
    this.labelText,
    this.labelStyle,
  });
  TextEditingController controllers = TextEditingController();
  String? labelText;
  TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding - 6),
      onChanged: (p0) {},
      labelText: labelText,
      labelStyle: labelStyle,
      controller: controllers,
      style: kBodyStyle.copyWith(
          color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 18),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding - 4)),
        borderSide: BorderSide(color: AppColors.secondTextColor),
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding - 4)),
          borderSide: BorderSide(color: AppColors.themeColor)),
    );
  }
}
