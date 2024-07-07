part of '../screens/food_screen.dart';

extension _FoodCreateOrUpdateDialog on _FoodViewState {
  Widget _createOrUpdateFoodDialog() {
    return SizedBox(
      width: 600.w,
      height: 800.w,
      child: Column(
        children: [
          30.verticalSpace,
          Text('Thêm món mới'.toUpperCase(),
              style: kHeadingStyle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 40.sp)),
          _buildBodyCreateOrUpdateFoodDialog(),
        ],
      ),
    );
  }

  void _showCreateOrUpdateDialog(FoodItem? foodItem) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: AppColors.background,
              child: _createOrUpdateFoodDialog(),
            ));
  }

  _buildBodyCreateOrUpdateFoodDialog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          10.verticalSpace,
          _buildRowImageFoodWidget(),
          20.verticalSpace,
          _buildNameFoodTextField(),
          20.verticalSpace,
          _buildDescriptionFoodTextField()
        ],
      ),
    );
  }

  Widget _buildNameFoodTextField() {
    return CommonTextField(
      controller: _nameFoodController,
      hintText: 'Tên món ăn',
      filled: true,
      onChanged: (String) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tên món không được để trống';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: Icon(
        Icons.fastfood_outlined,
        size: 20.sp,
        color: AppColors.secondTextColor,
      ),
    );
  }

  Widget _buildDescriptionFoodTextField() {
    return CommonTextField(
      controller: _descriptionFoodController,
      hintText: 'Mô tả món ăn',
      filled: true,
      onChanged: (String) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Một môn không được này';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: Icon(
        Icons.description_outlined,
        size: 20.sp,
        color: AppColors.secondTextColor,
      ),
    );
  }

  _buildRowImageFoodWidget() {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          _buildItemImage(),
          _buildItemImage(),
          _buildItemImage(),
          _buildItemImage()
        ],
      ),
    );
  }

  _buildItemImage() {
    return Expanded(
        child: Card(
      child: Center(
          child: Icon(Icons.add_photo_alternate_outlined,
              color: AppColors.secondTextColor, size: 20.sp)),
    ));
  }
}
