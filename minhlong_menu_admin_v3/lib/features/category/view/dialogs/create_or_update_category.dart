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
import '../../../../core/app_const.dart';
import '../../../../core/app_enum.dart';
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
                  _type == ScreenType.create
                      ? 'Thêm danh mục'.toUpperCase()
                      : 'Sửa danh mục'.toUpperCase(),
                  style: context.bodyMedium!.copyWith(
                    color: context.bodyMedium!.color!.withOpacity(0.5),
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
    return Card(
      elevation: 1,
      surfaceTintColor: context.colorScheme.surfaceTint,
      child: InkWell(
        onTap: () async => await Ultils.pickImage().then((value) {
          if (value != null) {
            _imageFile.value = value;
          }
        }),
        child: SizedBox(
          height: 150.h,
          width: 150.h,
          child: ValueListenableBuilder(
            valueListenable: _imageFile,
            builder: (context, value, child) {
              return value.path.isNotEmpty
                  ? Image.file(
                      value,
                      fit: BoxFit.cover,
                      height: 150.h,
                      width: 150.h,
                    )
                  : _image.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.5),
                              size: 20,
                            ),
                            Text(
                              '500 x 500',
                              style: context.bodyMedium!.copyWith(
                                color:
                                    context.bodyMedium!.color!.withOpacity(0.5),
                              ),
                            ),
                          ],
                        )
                      : CachedNetworkImage(
                          imageUrl: '${ApiConfig.host}$_image',
                          errorWidget: errorBuilderForImage,
                          fit: BoxFit.cover,
                          height: 150.h,
                          width: 150.h,
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
      prefixIcon: Icon(
        Icons.category_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
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
      prefixIcon: Icon(
        Icons.format_list_numbered_rounded,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
  }

  _buildButton() {
    return ElevatedButton(
      onPressed: () {
        _handleCreateOrUpdateCategory();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        minimumSize: const Size(200, 45),
      ),
      child: Text(
        _type == ScreenType.create ? 'Thêm' : 'Cập nhật',
        style: context.bodyMedium!.copyWith(color: Colors.white),
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
