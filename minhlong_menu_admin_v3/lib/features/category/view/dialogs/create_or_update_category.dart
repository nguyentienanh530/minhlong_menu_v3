import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_item.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/app_style.dart';
import '../../../../core/extensions.dart';
import '../../bloc/category_bloc.dart';

class CreateOrUpdateCategory extends StatefulWidget {
  const CreateOrUpdateCategory({
    super.key,
    required this.type,
    this.categoryItem,
  });

  final ScreenType type;
  final CategoryItem? categoryItem;

  @override
  State<CreateOrUpdateCategory> createState() => _CreateOrUpdateCategoryState();
}

class _CreateOrUpdateCategoryState extends State<CreateOrUpdateCategory> {
  late ScreenType _type;
  final _nameCategoryController = TextEditingController();
  final _serialCategoryController = TextEditingController();
  final _imageFile = ValueNotifier(File(''));
  String _image = '';
  final _imageUploadProgress = ValueNotifier(0.0);
  late CategoryItem _categoryItem;

  @override
  void initState() {
    super.initState();
    _type = widget.type;

    if (_type == ScreenType.update) {
      _categoryItem = widget.categoryItem!;
      _nameCategoryController.text = _categoryItem.name;
      _serialCategoryController.text = _categoryItem.serial.toString();
      _image = _categoryItem.image;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameCategoryController.dispose();
    _serialCategoryController.dispose();
    _imageFile.dispose();
    _imageUploadProgress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        constraints: const BoxConstraints(maxWidth: 500),
        child: BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryCreateInProgress ||
                state is CategoryUpdateInProgress) {
              AppDialog.showLoadingDialog(context,
                  isProgressed: _imageFile.value.path.isNotEmpty ? true : false,
                  progressValue: _imageUploadProgress.value,
                  imageName: _image);
            }
            if (state is CategoryCreateSuccess ||
                state is CategoryUpdateSuccess) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Thao tác thành công');
            }
            if (state is CategoryCreateFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, state.message,
                  type: OverlaySnackbarType.error);
            }

            if (state is CategoryUpdateFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, state.message,
                  type: OverlaySnackbarType.error);
            }
          },
          child: Form(
            key: AppKeys.createOrUpdateCategoryKey,
            child: Column(
              children: [
                Text(
                  _type == ScreenType.create ? 'Thêm danh mục' : 'Sửa danh mục',
                  style: kBodyStyle.copyWith(
                    color: AppColors.secondTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.sp,
                  ),
                ),
                20.verticalSpace,
                _buildCategoryImageWidget(),
                20.verticalSpace,
                _buildCategoryNameTextField(),
                20.verticalSpace,
                _buildCategorySerialTextField(),
                20.verticalSpace,
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCategoryImageWidget() {
    return InkWell(
      onTap: () async => await Ultils.pickImage().then((value) {
        if (value != null) {
          _imageFile.value = value;
        }
      }),
      child: Card(
        elevation: 4,
        shadowColor: AppColors.lavender,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius).r,
          ),
          child: ValueListenableBuilder(
            valueListenable: _imageFile,
            builder: (context, value, child) {
              return value.path.isNotEmpty
                  ? Image.file(value, fit: BoxFit.cover)
                  : _image.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.secondTextColor,
                              size: 20,
                            ),
                            Text(
                              '500 x 500',
                              style: kCaptionStyle.copyWith(
                                color: AppColors.secondTextColor,
                              ),
                            ),
                          ],
                        )
                      : CachedNetworkImage(
                          imageUrl: '${ApiConfig.host}$_image',
                          errorWidget: errorBuilderForImage,
                          fit: BoxFit.cover,
                        );
            },
          ),
        ),
      ),
    );
  }

  _buildCategoryNameTextField() {
    return CommonTextField(
      controller: _nameCategoryController,
      hintText: 'Tên danh mục',
      filled: true,
      maxLines: 1,
      prefixIcon: const Icon(
        Icons.category_outlined,
        size: 20,
        color: AppColors.secondTextColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tên danh mục không được để trống';
        }
        return null;
      },
    );
  }

  _buildCategorySerialTextField() {
    return CommonTextField(
      controller: _serialCategoryController,
      hintText: 'Thứ tự hiển thị',
      filled: true,
      maxLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Thứ tự hiện thị không được để trống';
        }
        return null;
      },
      prefixIcon: const Icon(
        Icons.format_list_numbered_rounded,
        size: 20,
        color: AppColors.secondTextColor,
      ),
    );
  }

  _buildButton() {
    return InkWell(
      onTap: () {
        _handleCreateOrUpdateCategory();
      },
      child: Container(
        height: 35,
        width: 200.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: AppColors.themeColor,
        ),
        child: Text(
          _type == ScreenType.create ? 'Thêm' : 'Cập nhật',
          style: kBodyStyle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  void _handleCreateOrUpdateCategory() async {
    if (AppKeys.createOrUpdateCategoryKey.currentState!.validate()) {
      AppKeys.createOrUpdateCategoryKey.currentState!.save();
      if (_imageFile.value.path.isNotEmpty) {
        _image = await Ultils.uploadImage(
                file: _imageFile.value,
                path: 'categories',
                loading: _imageUploadProgress) ??
            '';
      }
      if (_type == ScreenType.create) {
        var category = CategoryItem(
          name: _nameCategoryController.text,
          serial: int.parse(_serialCategoryController.text),
          image: _image,
        );
        _createCategory(category);
      } else {
        _categoryItem = _categoryItem.copyWith(
          name: _nameCategoryController.text,
          serial: int.parse(_serialCategoryController.text),
          image: _image,
        );
        _updateCategory(_categoryItem);
      }
    }
  }

  void _createCategory(CategoryItem category) {
    context.read<CategoryBloc>().add(CategoryCreated(category));
  }

  void _updateCategory(CategoryItem category) {
    context.read<CategoryBloc>().add(CategoryUpdated(category));
  }
}
