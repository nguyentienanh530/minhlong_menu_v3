import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_item.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_item.dart';

import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/extensions.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/repositories/category_repository.dart';
import '../../bloc/food_bloc/food_bloc.dart';

class CreateOrUpdateFoodDialog extends StatefulWidget {
  const CreateOrUpdateFoodDialog(
      {super.key, required this.mode, this.foodItem});
  final ScreenType mode;
  final FoodItem? foodItem;

  @override
  State<CreateOrUpdateFoodDialog> createState() =>
      _FoodCreateOrUpdateDialogState();
}

class _FoodCreateOrUpdateDialogState extends State<CreateOrUpdateFoodDialog> {
  final _nameFoodController = TextEditingController();
  final _priceFoodController = TextEditingController();
  final _descriptionFoodController = TextEditingController();
  final _discountFoodController = TextEditingController();
  final _categoryValueNotifier = ValueNotifier(CategoryItem());
  late ScreenType _mode;

  final _imageFile1 = ValueNotifier(File(''));
  final _imageFile2 = ValueNotifier(File(''));
  final _imageFile3 = ValueNotifier(File(''));
  final _imageFile4 = ValueNotifier(File(''));
  final _applyforDiscount = ValueNotifier(FoodDiscountType.doNotApply);
  final _loadingProgress1 = ValueNotifier(0.0);
  final _loadingProgress2 = ValueNotifier(0.0);
  final _loadingProgress3 = ValueNotifier(0.0);
  final _loadingProgress4 = ValueNotifier(0.0);
  FoodItem? _foodItem;
  var _image1 = '';
  var _image2 = '';
  var _image3 = '';
  var _image4 = '';

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;

    if (_mode == ScreenType.update) {
      _foodItem = widget.foodItem!;
      _nameFoodController.text = _foodItem?.name ?? '';
      _priceFoodController.text = _foodItem?.price.toString() ?? '';
      _descriptionFoodController.text = _foodItem?.description ?? '';
      _discountFoodController.text = _foodItem?.discount.toString() ?? '';
      _applyforDiscount.value = _foodItem!.isDiscount!
          ? FoodDiscountType.apply
          : FoodDiscountType.doNotApply;
      _image1 = _foodItem?.image1 ?? '';
      _image2 = _foodItem?.image2 ?? '';
      _image3 = _foodItem?.image3 ?? '';
      _image4 = _foodItem?.image4 ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFoodController.dispose();
    _priceFoodController.dispose();
    _descriptionFoodController.dispose();
    _discountFoodController.dispose();
    _imageFile1.dispose();
    _imageFile2.dispose();
    _imageFile3.dispose();
    _imageFile4.dispose();
    _applyforDiscount.dispose();
    _loadingProgress1.dispose();
    _loadingProgress2.dispose();
    _loadingProgress3.dispose();
    _loadingProgress4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryBloc(categoryRepository: context.read<CategoryRepository>())
            ..add(CategoryFetched()),
      child: SizedBox(
        width: 500,
        child: BlocListener<FoodBloc, FoodState>(
          listener: (context, state) {
            if (state is FoodCreateInProgress ||
                state is FoodUpdateInProgress) {
              AppDialog.showLoadingDialog(context);
            }
            if (state is FoodCreateSuccess) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Tạo mới thành công');
              _resetForm();
            }
            if (state is FoodUpdateSuccess) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Tạo mới thành công');
            }
            if (state is FoodCreateFailure) {
              Navigator.pop(context);
              OverlaySnackbar.show(context, state.message,
                  type: OverlaySnackbarType.error);
            }

            if (state is FoodCreateFailure) {
              Navigator.pop(context);
              OverlaySnackbar.show(context, state.message,
                  type: OverlaySnackbarType.error);
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: AppKeys.createOrUpdateKey,
              child: Builder(
                builder: (context) {
                  var categoryState = context.watch<CategoryBloc>().state;
                  return (switch (categoryState) {
                    CategoryFetchInProgress() => const Loading(),
                    CategoryFetchFailure(message: final msg) =>
                      ErrWidget(error: msg),
                    CategoryFetchSuccess() => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 52, horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                                _mode == ScreenType.create
                                    ? 'Thêm món mới'.toUpperCase()
                                    : 'Chỉnh sửa'.toUpperCase(),
                                style: context.titleStyleLarge!.copyWith(
                                    color: context.titleStyleLarge!.color!
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40)),
                            _buildBodyCreateOrUpdateFoodDialog(
                                categoryState.categoryModel.categoryItems),
                            20.verticalSpace,
                            _buildButtonCreateOrUpdateFood(),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    _ => const SizedBox.shrink()
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBodyCreateOrUpdateFoodDialog(List<CategoryItem> categories) {
    if (_foodItem == null) {
      _categoryValueNotifier.value = categories[0];
    } else {
      _categoryValueNotifier.value = categories
          .where((element) => element.id == _foodItem?.categoryID)
          .first;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          // 10.verticalSpace,
          _buildRowImageFoodWidget(),
          20.verticalSpace,
          _buildNameFoodTextField(),
          20.verticalSpace,
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Row(children: [
              Expanded(child: _buildPriceFoodTextField()),
              20.horizontalSpace,
              Expanded(child: _buildDropDownCategory(categories))
            ]),
          ),
          20.verticalSpace,
          _buildDescriptionFoodTextField(),
          20.verticalSpace,

          SizedBox(
            height: 70,
            width: double.infinity,
            child: Row(children: [
              Flexible(child: _buildApplyForDiscountWidget()),
              20.horizontalSpace,
              Flexible(child: _buildDiscountTextField())
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildApplyForDiscountWidget() {
    return ValueListenableBuilder(
      valueListenable: _applyforDiscount,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Radio<FoodDiscountType>(
                    value: FoodDiscountType.apply,
                    fillColor: WidgetStateProperty.all(
                        context.bodyMedium!.color!.withOpacity(0.5)),
                    groupValue: _applyforDiscount.value,
                    onChanged: (value) {
                      _applyforDiscount.value = value!;
                    },
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Áp dụng',
                        style: context.bodyMedium!.copyWith(
                            color: context.bodyMedium!.color!.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio<FoodDiscountType>(
                    fillColor: WidgetStateProperty.all(
                        context.bodyMedium!.color!.withOpacity(0.5)),
                    value: FoodDiscountType.doNotApply,
                    groupValue: _applyforDiscount.value,
                    onChanged: (value) {
                      _applyforDiscount.value = value!;
                    },
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('Không',
                          style: context.bodyMedium!.copyWith(
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.5))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiscountTextField() {
    return ValueListenableBuilder(
        valueListenable: _applyforDiscount,
        builder: (context, value, child) {
          return CommonTextField(
            controller: _discountFoodController,
            enabled: value == FoodDiscountType.apply ? true : false,
            hintText: 'Khuyến mãi',
            filled: true,
            validator: _applyforDiscount.value == FoodDiscountType.apply
                ? (textFieldvalue) {
                    if (textFieldvalue == null || textFieldvalue.isEmpty) {
                      return 'Khuyến mãi không hợp lệ';
                    }
                    return null;
                  }
                : null,
            maxLines: 1,
            suffixIcon: Icon(
              Icons.percent_outlined,
              size: 20,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.discount_rounded,
              size: 20,
              color: context.bodyMedium!.color!.withOpacity(0.5),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          );
        });
  }

  Widget _buildNameFoodTextField() {
    return CommonTextField(
      controller: _nameFoodController,
      hintText: 'Tên món ăn',
      filled: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tên món không được để trống';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: Icon(
        Icons.fastfood_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
  }

  Widget _buildDescriptionFoodTextField() {
    return CommonTextField(
      controller: _descriptionFoodController,
      hintText: 'Mô tả món ăn',
      filled: true,
      // maxLines: 1,
      prefixIcon: Icon(
        Icons.description_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
  }

  _buildRowImageFoodWidget() {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          _buildItemImage(imageFile: _imageFile1, image: _image1),
          10.horizontalSpace,
          _buildItemImage(imageFile: _imageFile2, image: _image2),
          10.horizontalSpace,
          _buildItemImage(imageFile: _imageFile3, image: _image3),
          10.horizontalSpace,
          _buildItemImage(imageFile: _imageFile4, image: _image4),
        ],
      ),
    );
  }

  _buildItemImage({required ValueNotifier imageFile, required String image}) {
    return ValueListenableBuilder(
      valueListenable: imageFile,
      builder: (context, value, child) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(defaultPadding),
            onTap: () async => await Ultils.pickImage().then((value) {
              if (value == null) {
                return;
              }
              imageFile.value = value;
            }),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius).r,
                border: Border.all(
                    color: context.colorScheme.onPrimaryContainer
                        .withOpacity(0.5)),
              ),
              child: imageFile.value.path.isEmpty
                  ? image.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.8),
                              size: 20,
                            ),
                            Text(
                              '500 x 500',
                              style: context.bodyMedium!.copyWith(
                                color:
                                    context.bodyMedium!.color!.withOpacity(0.8),
                              ),
                            ),
                          ],
                        )
                      : CachedNetworkImage(
                          imageUrl: '${ApiConfig.host}$image',
                          fit: BoxFit.cover,
                          errorWidget: errorBuilderForImage,
                        )
                  : Image.file(
                      imageFile.value,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        );
      },
    );
  }

  _buildPriceFoodTextField() {
    return CommonTextField(
      controller: _priceFoodController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      hintText: 'Giá',
      filled: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Giá món không được này';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: Icon(
        Icons.attach_money_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
  }

  _buildButtonCreateOrUpdateFood() {
    return InkWell(
      onTap: () {
        _handleCrteteOrUpdateFood();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          _mode == ScreenType.create ? 'Tạo món' : 'Sửa',
          style: context.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDropDownCategory(List<CategoryItem> categories) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
        border: Border.all(color: Colors.white54),
      ),
      child: Row(
        children: [
          Icon(
            Icons.category_outlined,
            size: 20,
            color: context.bodyMedium!.color!.withOpacity(0.8),
          ),
          10.horizontalSpace,
          ValueListenableBuilder(
            valueListenable: _categoryValueNotifier,
            builder: (context, value, child) {
              return Expanded(
                child: DropdownButton<CategoryItem>(
                  isExpanded: true,
                  hint: Text('Danh mục',
                      style: context.bodyMedium!.copyWith(
                          color: context.bodyMedium!.color!.withOpacity(0.8))),
                  padding: const EdgeInsets.all(0),
                  value: _categoryValueNotifier.value,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  borderRadius: BorderRadius.circular(defaultBorderRadius).r,
                  underline: const SizedBox(),
                  style: context.bodyMedium!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.8)),
                  // value: _categoryId,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _categoryValueNotifier.value = value!;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleCrteteOrUpdateFood() async {
    if (AppKeys.createOrUpdateKey.currentState!.validate()) {
      AppKeys.createOrUpdateKey.currentState!.save();
      if (_imageFile1.value.path.isNotEmpty) {
        _image1 = await Ultils.uploadImage(
                file: _imageFile1.value,
                path: 'foods',
                loading: _loadingProgress1) ??
            '';
      }
      if (_imageFile2.value.path.isNotEmpty) {
        _image2 = await Ultils.uploadImage(
                file: _imageFile2.value,
                path: 'foods',
                loading: _loadingProgress2) ??
            '';
      }
      if (_imageFile3.value.path.isNotEmpty) {
        _image3 = await Ultils.uploadImage(
                file: _imageFile3.value,
                path: 'foods',
                loading: _loadingProgress3) ??
            '';
      }
      if (_imageFile4.value.path.isNotEmpty) {
        _image4 = await Ultils.uploadImage(
                file: _imageFile4.value,
                path: 'foods',
                loading: _loadingProgress4) ??
            '';
      }

      if (_mode == ScreenType.create) {
        var food = FoodItem();
        food = food.copyWith(
          name: _nameFoodController.text,
          categoryID: _categoryValueNotifier.value.id,
          orderCount: 0,
          description: _descriptionFoodController.text,
          discount: _applyforDiscount.value == FoodDiscountType.apply
              ? int.parse(_discountFoodController.text)
              : 0,
          isDiscount:
              _applyforDiscount.value == FoodDiscountType.apply ? true : false,
          isShow: true,
          price: double.parse(_priceFoodController.text),
          image1: _image1,
          image2: _image2,
          image3: _image3,
          image4: _image4,
        );

        _createFood(food);
      } else {
        var food = FoodItem();
        food = food.copyWith(
          id: _foodItem!.id,
          name: _nameFoodController.text,
          categoryID: _categoryValueNotifier.value.id,
          orderCount: _foodItem!.orderCount,
          description: _descriptionFoodController.text,
          discount: _applyforDiscount.value == FoodDiscountType.apply
              ? int.parse(_discountFoodController.text)
              : 0,
          isDiscount:
              _applyforDiscount.value == FoodDiscountType.apply ? true : false,
          isShow: true,
          price: double.parse(_priceFoodController.text),
          image1: _image1.isEmpty ? _foodItem!.image1 : _image1,
          image2: _image2.isEmpty ? _foodItem!.image2 : _image2,
          image3: _image3.isEmpty ? _foodItem!.image3 : _image3,
          image4: _image4.isEmpty ? _foodItem!.image4 : _image4,
        );
        _updateFood(food);
      }
    }
  }

  void _createFood(FoodItem food) {
    context.read<FoodBloc>().add(FoodCreated(food: food));
  }

  void _updateFood(FoodItem food) {
    context.read<FoodBloc>().add(FoodUpdated(food: food));
  }

  void _resetForm() {
    _nameFoodController.clear();
    _priceFoodController.clear();
    _descriptionFoodController.clear();
    _discountFoodController.clear();
    _imageFile1.value = File('');
    _imageFile2.value = File('');
    _imageFile3.value = File('');
    _imageFile4.value = File('');
    _applyforDiscount.value = FoodDiscountType.doNotApply;
  }
}
