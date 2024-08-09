import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/banner/bloc/banner_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_item.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/extensions.dart';

class CreateOrUpdateBanner extends StatefulWidget {
  const CreateOrUpdateBanner({
    super.key,
    required this.type,
    this.bannItem,
  });

  final ScreenType type;
  final BannerItem? bannItem;

  @override
  State<CreateOrUpdateBanner> createState() => _CreateOrUpdateBannerState();
}

class _CreateOrUpdateBannerState extends State<CreateOrUpdateBanner> {
  late ScreenType _type;

  final _imageFile = ValueNotifier(File(''));
  String _image = '';
  final _imageUploadProgress = ValueNotifier(0.0);
  final _isShowBanner = ValueNotifier(true);
  late BannerItem _bannItem;

  @override
  void initState() {
    super.initState();
    _type = widget.type;

    if (_type == ScreenType.update) {
      _bannItem = widget.bannItem!;
      _image = _bannItem.image;
      _isShowBanner.value = _bannItem.show ?? false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile.dispose();
    _imageUploadProgress.dispose();
    _isShowBanner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsAlignment: MainAxisAlignment.center,
      title: Row(
        children: [
          Text(
            _type == ScreenType.create
                ? 'Thêm Banner'.toUpperCase()
                : 'Sửa Banner'.toUpperCase(),
            style: context.titleStyleLarge!.copyWith(
              color: context.bodyMedium!.color!.withOpacity(0.5),
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.close),
          )
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: BlocListener<BannerBloc, BannerState>(
          listener: (context, state) {
            if (state is BannerCreateInProgress ||
                state is BannerUpdateInProgress) {
              AppDialog.showLoadingDialog(context,
                  isProgressed: _imageFile.value.path.isNotEmpty ? true : false,
                  progressValue: _imageUploadProgress.value,
                  imageName: _image);
            }
            if (state is BannerCreateSuccess || state is BannerUpdateSuccess) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Thao tác thành công');
            }
            if (state is BannerCreateFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, state.errorMessage,
                  type: OverlaySnackbarType.error);
            }

            if (state is BannerUpdateFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, state.errorMessage,
                  type: OverlaySnackbarType.error);
            }
          },
          child: Form(
            key: AppKeys.createOrUpdateCategoryKey,
            child: Column(
              children: [
                _buildCategoryImageWidget(),
                20.verticalSpace,
                _buildApplyForDiscountWidget(),
              ],
            ),
          ),
        ),
      ),
      actions: [_buildButton()],
    );
  }

  Widget _buildApplyForDiscountWidget() {
    return ValueListenableBuilder(
      valueListenable: _isShowBanner,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trạng thái',
              style: context.bodyMedium!
                  .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
            ),
            Row(children: [
              Radio<bool>(
                value: true,
                fillColor: WidgetStateProperty.all(
                    context.bodyMedium!.color!.withOpacity(0.5)),
                groupValue: _isShowBanner.value,
                onChanged: (value) {
                  _isShowBanner.value = value!;
                },
              ),
              Text(
                'Hiển thị',
                style: context.bodyMedium!.copyWith(
                    color: context.bodyMedium!.color!.withOpacity(0.5)),
              ),
              20.horizontalSpace,
              Radio<bool>(
                fillColor: WidgetStateProperty.all(
                    context.bodyMedium!.color!.withOpacity(0.5)),
                value: false,
                groupValue: _isShowBanner.value,
                onChanged: (value) {
                  _isShowBanner.value = value!;
                },
              ),
              Text(
                'Ẩn',
                style: context.bodyMedium!.copyWith(
                    color: context.bodyMedium!.color!.withOpacity(0.5)),
              ),
            ])
          ],
        );
      },
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
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 250,
          width: double.infinity,
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
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color:
                                  context.bodyMedium!.color!.withOpacity(0.5),
                              size: 20,
                            ),
                            Text(
                              '900 x 500',
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
                        );
            },
          ),
        ),
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
                path: 'banners',
                loading: _imageUploadProgress) ??
            '';
      }
      if (_type == ScreenType.create) {
        var banner = BannerItem(
          image: _image,
          show: _isShowBanner.value,
        );
        _createBanner(banner);
      } else {
        _bannItem =
            _bannItem.copyWith(image: _image, show: _isShowBanner.value);
        _updateBanner(_bannItem);
      }
    }
  }

  void _createBanner(BannerItem banner) {
    context.read<BannerBloc>().add(BannerCreated(banner: banner));
  }

  void _updateBanner(BannerItem banner) {
    context.read<BannerBloc>().add(BannerUpdated(banner: banner));
  }
}
