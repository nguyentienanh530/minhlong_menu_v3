part of '../screens/setting_screen.dart';

extension _EditSettingWidget on _SettingScreenState {
  Widget _imageEditProfileWidget() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          _buildUserNameTextField(),
          20.verticalSpace,
          _buildPhoneTextField(),
          10.verticalSpace,
          20.verticalSpace,
          _buttonEditProfile(),
        ],
      ),
    );
  }

  Widget _buildUserNameTextField() {
    return CommonTextField(
      onChanged: (p0) {},
      controller: _nameController,
      labelText: AppString.fullName,
      labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      hintStyle: kBodyStyle,
      style: kBodyStyle,
    );
  }

  Widget _buildPhoneTextField() {
    return CommonTextField(
      onChanged: (p0) {},
      controller: _phoneController,
      labelText: AppString.phoneNumber,
      labelStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      hintStyle: kBodyStyle,
      style: kBodyStyle,
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
          _buildOldPassworTextField(),
          20.verticalSpace,
          Text(
            '${AppString.newPassword} *',
            style: kBodyStyle.copyWith(
                color: AppColors.secondTextColor, fontWeight: FontWeight.bold),
          ),
          5.verticalSpace,
          _buildNewPassworTextField(),
          20.verticalSpace,
          Text(
            '${AppString.reNewPassword} *',
            style: kBodyStyle.copyWith(
                color: AppColors.secondTextColor, fontWeight: FontWeight.bold),
          ),
          5.verticalSpace,
          _buildComfirmPassworTextField(),
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

  Widget _buildOldPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowOldPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _oldPasswordController,
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
                onTap: () =>
                    _isShowOldPassword.value = !_isShowOldPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }

  Widget _buildNewPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowNewPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _newPasswordController,
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
                onTap: () =>
                    _isShowNewPassword.value = !_isShowNewPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }

  Widget _buildComfirmPassworTextField() {
    return ValueListenableBuilder(
      valueListenable: _isShowConfirmPassword,
      builder: (context, value, child) {
        return CommonTextField(
            maxLines: 1,
            style: kBodyStyle,
            controller: _confirmPasswordController,
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
                onTap: () => _isShowConfirmPassword.value =
                    !_isShowConfirmPassword.value,
                child: Icon(
                    !value ? Icons.visibility_off : Icons.remove_red_eye,
                    color: AppColors.secondTextColor.withOpacity(0.5))));
      },
    );
  }
}
