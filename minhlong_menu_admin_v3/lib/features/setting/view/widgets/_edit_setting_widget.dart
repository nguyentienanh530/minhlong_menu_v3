part of '../screens/setting_screen.dart';

extension _EditSettingWidget on _SettingScreenState {
  Widget _imageEditProfileWidget() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
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
                    imageUrl: _userList[0],
                    errorWidget: errorBuilderForImage,
                    placeholder: (context, url) => const Loading(),
                  ),
                ),
              ),
              Positioned(bottom: 15, right: 20, child: _uploadImage())
            ],
          ),
          10.verticalSpace,
          _bodyEditInfoUser()
        ],
      ),
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
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textProfile(AppString.fullName),
          _TextBoxProfile(controllers: _nameController),
          10.verticalSpace,
          _textProfile(AppString.email),
          _TextBoxProfile(controllers: _emailController),
          10.verticalSpace,
          _textProfile(AppString.phoneNumber),
          _TextBoxProfile(controllers: _phoneController),
          20.verticalSpace,
          _buttonEditProfile(),
        ],
      ),
    );
  }

  Widget _buildChangePassword() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(AppString.changePassword,
                style: kHeadingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: AppColors.secondTextColor)),
          ),
          20.verticalSpace,
          Text(
            '${AppString.oldPassword} *',
            style: kBodyStyle.copyWith(
                color: AppColors.secondTextColor, fontWeight: FontWeight.bold),
          ),
          5.verticalSpace,
          _PasswordFieldBox(
            passwordCtrl: _oldPassController,
          ),
          20.verticalSpace,
          Text(
            '${AppString.newPassword} *',
            style: kBodyStyle.copyWith(
                color: AppColors.secondTextColor, fontWeight: FontWeight.bold),
          ),
          5.verticalSpace,
          _PasswordFieldBox(
            passwordCtrl: _newPassController,
          ),
          20.verticalSpace,
          Text(
            '${AppString.reNewPassword} *',
            style: kBodyStyle.copyWith(
                color: AppColors.secondTextColor, fontWeight: FontWeight.bold),
          ),
          5.verticalSpace,
          _PasswordFieldBox(
            passwordCtrl: _reNewPassController,
          ),
          40.verticalSpace,
          _buttonChangePassword(),
        ],
      ),
    );
  }

  Widget _buttonChangePassword() {
    return Center(
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

class _PasswordFieldBox extends StatelessWidget {
  _PasswordFieldBox({required this.passwordCtrl});
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isShowPassword = ValueNotifier(false);

    return ValueListenableBuilder(
        valueListenable: isShowPassword,
        builder: (context, value, child) {
          return CommonTextField(
              maxLines: 1,
              style: kBodyWhiteStyle,
              controller: passwordCtrl,
              onFieldSubmitted: (p0) {},
              labelText: AppString.password,
              // labelText: AppString.password,
              validator: (password) => AppRes.validatePassword(password)
                  ? null
                  : 'Mật khẩu không hợp lệ',
              onChanged: (value) {},
              obscureText: !value,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.secondTextColor.withOpacity(0.5),
              ),
              suffixIcon: GestureDetector(
                  onTap: () => isShowPassword.value = !isShowPassword.value,
                  child: Icon(
                      !value ? Icons.visibility_off : Icons.remove_red_eye,
                      color: AppColors.secondTextColor.withOpacity(0.5))));
        });
  }
}

class _TextBoxProfile extends StatelessWidget {
  _TextBoxProfile({required this.controllers, this.hintText, this.hintStyle});
  String? hintText;
  TextStyle? hintStyle;
  TextEditingController controllers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (p0) {},
      controller: controllers,
      hintText: hintText,
      hintStyle: hintStyle,
      style: kBodyStyle.copyWith(
          color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
