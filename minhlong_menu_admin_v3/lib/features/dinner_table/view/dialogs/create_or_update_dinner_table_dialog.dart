import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/bloc/dinner_table_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_style.dart';
import '../../../../core/extensions.dart';

enum DinnerTableDialogAction { create, update }

enum DinnerTableStatus { active, inactive }

class CreateOrUpdateDinnerTableDialog extends StatefulWidget {
  const CreateOrUpdateDinnerTableDialog(
      {super.key, required this.action, this.tableItem});
  final DinnerTableDialogAction action;
  final TableItem? tableItem;

  @override
  State<CreateOrUpdateDinnerTableDialog> createState() =>
      _CreateOrUpdateDinnerTableDialogState();
}

class _CreateOrUpdateDinnerTableDialogState
    extends State<CreateOrUpdateDinnerTableDialog> {
  late DinnerTableDialogAction _mode;
  final _dinnerTableNameCtrl = TextEditingController();
  final _dinnertableSeatCtrl = TextEditingController();
  final _dinnerTableStatus =
      ValueNotifier<DinnerTableStatus>(DinnerTableStatus.inactive);
  late TableItem _tableItem;

  @override
  void initState() {
    super.initState();
    _mode = widget.action;
    if (_mode == DinnerTableDialogAction.update) {
      _tableItem = widget.tableItem ?? TableItem();
      _dinnerTableNameCtrl.text = _tableItem.name;
      _dinnertableSeatCtrl.text = _tableItem.seats.toString();
      _dinnerTableStatus.value = _tableItem.isUse
          ? DinnerTableStatus.active
          : DinnerTableStatus.inactive;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dinnerTableNameCtrl.dispose();
    _dinnertableSeatCtrl.dispose();
    _dinnerTableStatus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: BlocListener<DinnerTableBloc, DinnerTableState>(
        listener: (context, state) {
          if (state is DinnerTableCreateInProgress ||
              state is DinnerTableUpdateInProgress) {
            AppDialog.showLoadingDialog(context);
          }

          if (state is DinnerTableCreateSuccess) {
            pop(context, 2);
            OverlaySnackbar.show(context, 'THÊM BÀN THÀNH CÔNG');
          }
          if (state is DinnerTableUpdateSuccess) {
            pop(context, 2);
            OverlaySnackbar.show(context, 'SỬA BÀN THÀNH CÔNG');
          }

          if (state is DinnerTableCreateFailure ||
              state is DinnerTableUpdateFailure) {
            Navigator.pop(context);
            OverlaySnackbar.show(context, 'Có lỗi xảy ra, thử lại sau',
                type: OverlaySnackbarType.error);
          }
        },
        child: Container(
            constraints: BoxConstraints(maxWidth: 500.h),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: AppKeys.createOrUpdateDinnerTableKey,
                child: Column(
                  children: [
                    Text(
                      _mode == DinnerTableDialogAction.create
                          ? 'THÊM BÀN MỚI'
                          : 'SỬA BÀN',
                      style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 40.sp,
                          color: AppColors.secondTextColor),
                    ),
                    20.verticalSpace,
                    _buildDinnerTableNameTextField(),
                    20.verticalSpace,
                    _buildDinnerTableSeatTextField(),
                    20.verticalSpace,
                    _buildApplyForDiscountWidget(),
                    20.verticalSpace,
                    _buildButtonCreateOrUpdateDinnerTable()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _buildDinnerTableNameTextField() {
    return CommonTextField(
      controller: _dinnerTableNameCtrl,
      hintText: 'Tên bàn',
      filled: true,
      maxLines: 1,
      prefixIcon: const Icon(
        Icons.table_bar_outlined,
        size: 20,
        color: AppColors.secondTextColor,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tên bàn không được trống';
        }
        return null;
      },
    );
  }

  Widget _buildApplyForDiscountWidget() {
    return ValueListenableBuilder(
      valueListenable: _dinnerTableStatus,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<DinnerTableStatus>(
                  value: DinnerTableStatus.active,
                  fillColor: WidgetStateProperty.all(AppColors.secondTextColor),
                  groupValue: _dinnerTableStatus.value,
                  onChanged: (value) {
                    _dinnerTableStatus.value = value!;
                  },
                ),
                Text(
                  'Sử dụng',
                  style:
                      kCaptionStyle.copyWith(color: AppColors.secondTextColor),
                ),
              ],
            ),
            30.horizontalSpace,
            Row(
              children: [
                Radio<DinnerTableStatus>(
                  fillColor: WidgetStateProperty.all(AppColors.secondTextColor),
                  value: DinnerTableStatus.inactive,
                  groupValue: _dinnerTableStatus.value,
                  onChanged: (value) {
                    _dinnerTableStatus.value = value!;
                  },
                ),
                Text('Không sử dụng',
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor)),
              ],
            ),
          ],
        );
      },
    );
  }

  _buildDinnerTableSeatTextField() {
    return CommonTextField(
      controller: _dinnertableSeatCtrl,
      hintText: 'Số ghế',
      filled: true,
      maxLines: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: const Icon(
        Icons.chair_alt_outlined,
        size: 20,
        color: AppColors.secondTextColor,
      ),
      validator: (p0) {
        if (p0 == null || p0.isEmpty) {
          return 'Vui lòng nhập số ghế';
        }
        return null;
      },
    );
  }

  _buildButtonCreateOrUpdateDinnerTable() {
    return InkWell(
      onTap: () {
        _handleCreateOrUpdateDinnerTable();
      },
      child: Container(
        height: 45,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            color: AppColors.themeColor),
        child: Text(
          _mode == DinnerTableDialogAction.create ? 'Thêm mới' : 'Sửa',
          style: kBodyWhiteStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _handleCreateOrUpdateDinnerTable() {
    if (AppKeys.createOrUpdateDinnerTableKey.currentState!.validate()) {
      if (_mode == DinnerTableDialogAction.create) {
        var dinnerTable = TableItem(
          name: _dinnerTableNameCtrl.text,
          seats: int.parse(_dinnertableSeatCtrl.text),
          isUse: _dinnerTableStatus.value == DinnerTableStatus.active
              ? true
              : false,
        );
        _createDinnerTable(table: dinnerTable);
      } else {
        _tableItem = _tableItem.copyWith(
          name: _dinnerTableNameCtrl.text,
          seats: int.parse(_dinnertableSeatCtrl.text),
          isUse: _dinnerTableStatus.value == DinnerTableStatus.active
              ? true
              : false,
        );
        _updateDinnerTable(table: _tableItem);
      }
    }
  }

  void _createDinnerTable({required TableItem table}) {
    context.read<DinnerTableBloc>().add(DinnerTableCreated(tableItem: table));
  }

  void _updateDinnerTable({required TableItem table}) {
    context.read<DinnerTableBloc>().add(DinnerTableUpdated(tableItem: table));
  }
}
