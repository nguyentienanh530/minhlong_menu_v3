import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_item.dart';

import '../../../../common/network/dio_client.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/model/category_model.dart';
import '../../../category/data/provider/category_api.dart';
import '../../../category/data/repositories/category_repository.dart';

enum FoodScreenMode { create, update }

enum FoodDiscountType { apply, doNotApply }

class CreateOrUpdateFoodDialog extends StatefulWidget {
  const CreateOrUpdateFoodDialog(
      {super.key, required this.mode, this.foodItem});
  final FoodScreenMode mode;
  final FoodItem? foodItem;

  @override
  State<CreateOrUpdateFoodDialog> createState() =>
      _FoodCreateOrUpdateDialogState();
}

class _FoodCreateOrUpdateDialogState extends State<CreateOrUpdateFoodDialog> {
  final _nameFoodController = TextEditingController();
  final _priceFoodController = TextEditingController();
  // final _statusFoodController = TextEditingController();
  final _descriptionFoodController = TextEditingController();
  final _discountFoodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _categoryValueNotifier = ValueNotifier('');
  final _applyforDiscount = ValueNotifier(FoodDiscountType.doNotApply);
  late FoodScreenMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;
  }

  @override
  void dispose() {
    super.dispose();
    _nameFoodController.dispose();
    _priceFoodController.dispose();
    _descriptionFoodController.dispose();
    _discountFoodController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          CategoryRepository(categoryApi: CategoryApi(dio: DioClient().dio!)),
      child: BlocProvider(
        create: (context) =>
            CategoryBloc(categoryRepository: context.read<CategoryRepository>())
              ..add(CategoryFetched()),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                                _mode == FoodScreenMode.create
                                    ? 'Thêm món mới'.toUpperCase()
                                    : 'Chỉnh sửa'.toUpperCase(),
                                style: kHeadingStyle.copyWith(
                                    color: AppColors.secondTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40)),
                            _buildBodyCreateOrUpdateFoodDialog(
                                categoryState.categories),
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

  _buildBodyCreateOrUpdateFoodDialog(List<CategoryModel> categories) {
    _categoryValueNotifier.value = categories[0].name;
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
                    fillColor:
                        WidgetStateProperty.all(AppColors.secondTextColor),
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
                        style: kCaptionStyle.copyWith(
                            color: AppColors.secondTextColor),
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
                    fillColor:
                        WidgetStateProperty.all(AppColors.secondTextColor),
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
                          style: kBodyStyle.copyWith(
                              color: AppColors.secondTextColor)),
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
            onChanged: (String) {},
            validator: (textFieldvalue) {
              if (textFieldvalue == null || textFieldvalue.isEmpty) {
                return 'Khuyến mãi không hợp lệ';
              }
              return null;
            },
            maxLines: 1,
            suffixIcon: const Icon(
              Icons.percent_outlined,
              size: 20,
              color: AppColors.secondTextColor,
            ),
            prefixIcon: const Icon(
              Icons.discount_rounded,
              size: 20,
              color: AppColors.secondTextColor,
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
      onChanged: (String) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tên món không được để trống';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: const Icon(
        Icons.fastfood_outlined,
        size: 20,
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
      prefixIcon: const Icon(
        Icons.description_outlined,
        size: 20,
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
    return const Expanded(
        child: Card(
      child: Center(
          child: Icon(Icons.add_photo_alternate_outlined,
              color: AppColors.secondTextColor, size: 20)),
    ));
  }

  _buildPriceFoodTextField() {
    return CommonTextField(
      controller: _priceFoodController,
      hintText: 'Giá',
      filled: true,
      onChanged: (String) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Giá món không được này';
        }
        return null;
      },
      maxLines: 1,
      prefixIcon: const Icon(
        Icons.attach_money_outlined,
        size: 20,
        color: AppColors.secondTextColor,
      ),
    );
  }

  _buildButtonCreateOrUpdateFood() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // Navigator.pop(context);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          _mode == FoodScreenMode.create ? 'Tạo món' : 'Sửa',
          style: kButtonWhiteStyle,
        ),
      ),
    );
  }

  Widget _buildDropDownCategory(List<CategoryModel> categories) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
          border: Border.all(color: AppColors.lavender),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.category_outlined,
              size: 20,
              color: AppColors.secondTextColor,
            ),
            10.horizontalSpace,
            ValueListenableBuilder(
                valueListenable: _categoryValueNotifier,
                builder: (context, value, child) {
                  return Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Danh mục',
                          style: kBodyStyle.copyWith(
                              color: AppColors.secondTextColor)),
                      padding: const EdgeInsets.all(0),
                      value: _categoryValueNotifier.value,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      borderRadius:
                          BorderRadius.circular(defaultBorderRadius).r,
                      underline: const SizedBox(),
                      style:
                          kBodyStyle.copyWith(color: AppColors.secondTextColor),
                      dropdownColor: AppColors.white,
                      // value: _categoryId,
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _categoryValueNotifier.value = value!;
                      },
                    ),
                  );
                })
          ],
        ));
  }
}
