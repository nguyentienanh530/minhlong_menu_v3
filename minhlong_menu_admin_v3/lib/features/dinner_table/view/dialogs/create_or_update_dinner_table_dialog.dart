import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/bloc/dinner_table_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/extensions.dart';

class CreateOrUpdateDinnerTableDialog extends StatefulWidget {
  const CreateOrUpdateDinnerTableDialog(
      {super.key, required this.action, this.tableItem});
  final ScreenType action;
  final TableItem? tableItem;

  @override
  State<CreateOrUpdateDinnerTableDialog> createState() =>
      _CreateOrUpdateDinnerTableDialogState();
}

class _CreateOrUpdateDinnerTableDialogState
    extends State<CreateOrUpdateDinnerTableDialog> {
  late ScreenType _mode;
  final _dinnerTableNameCtrl = TextEditingController();
  final _dinnertableSeatCtrl = TextEditingController();
  final _dinnerTableStatus =
      ValueNotifier<DinnerTableStatus>(DinnerTableStatus.inactive);
  late TableItem _tableItem;

  @override
  void initState() {
    super.initState();
    _mode = widget.action;
    if (_mode == ScreenType.update) {
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
    return BlocListener<DinnerTableBloc, DinnerTableState>(
      listener: (context, state) {
        if (state is DinnerTableCreateInProgress ||
            state is DinnerTableUpdateInProgress) {
          AppDialog.showLoadingDialog(context);
        }

        if (state is DinnerTableCreateSuccess) {
          pop(context, 2);
          OverlaySnackbar.show(context, 'Thêm bàn thành công!');
        }
        if (state is DinnerTableUpdateSuccess) {
          pop(context, 2);
          OverlaySnackbar.show(context, 'Sửa bàn thành công!');
        }

        if (state is DinnerTableCreateFailure ||
            state is DinnerTableUpdateFailure) {
          Navigator.pop(context);
          OverlaySnackbar.show(context, 'Có lỗi xảy ra, thử lại sau',
              type: OverlaySnackbarType.error);
        }
      },
      child: AlertDialog(
        scrollable: true,
        surfaceTintColor: context.colorScheme.surfaceTint,
        actionsAlignment: MainAxisAlignment.center,
        title: Row(
          children: [
            Text(
              _mode == ScreenType.create ? 'THÊM BÀN MỚI' : 'SỬA BÀN',
              style: context.titleStyleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.bodyMedium!.color!.withOpacity(0.5)),
            ),
            Spacer(),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close))
          ],
        ),
        content: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Form(
            key: AppKeys.createOrUpdateDinnerTableKey,
            child: Column(
              children: [
                20.verticalSpace,
                _buildDinnerTableNameTextField(),
                20.verticalSpace,
                _buildDinnerTableSeatTextField(),
                20.verticalSpace,
                _buildApplyForDiscountWidget(),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        actions: [_buildButtonCreateOrUpdateDinnerTable()],
      ),
    );
  }

  _buildDinnerTableNameTextField() {
    return CommonTextField(
      controller: _dinnerTableNameCtrl,
      labelText: 'Tên bàn',
      maxLines: 1,
      prefixIcon: Icon(
        Icons.table_bar_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
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
                  fillColor: WidgetStateProperty.all(
                      context.bodyMedium!.color!.withOpacity(0.5)),
                  groupValue: _dinnerTableStatus.value,
                  onChanged: (value) {
                    _dinnerTableStatus.value = value!;
                  },
                ),
                Text(
                  'Sử dụng',
                  style: context.bodyMedium!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.5)),
                ),
              ],
            ),
            30.horizontalSpace,
            Row(
              children: [
                Radio<DinnerTableStatus>(
                  fillColor: WidgetStateProperty.all(
                      context.bodyMedium!.color!.withOpacity(0.5)),
                  value: DinnerTableStatus.inactive,
                  groupValue: _dinnerTableStatus.value,
                  onChanged: (value) {
                    _dinnerTableStatus.value = value!;
                  },
                ),
                Text('Không sử dụng',
                    style: context.bodyMedium!.copyWith(
                        color: context.bodyMedium!.color!.withOpacity(0.5))),
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
      labelText: 'Số ghế',
      maxLines: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Icon(
        Icons.chair_alt_outlined,
        size: 20,
        color: context.bodyMedium!.color!.withOpacity(0.5),
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
    return ElevatedButton(
      onPressed: () {
        _handleCreateOrUpdateDinnerTable();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        minimumSize: const Size(200, 45),
      ),
      child: Text(
        _mode == ScreenType.create ? 'Thêm mới' : 'Sửa',
        style: context.bodyMedium!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _handleCreateOrUpdateDinnerTable() {
    if (AppKeys.createOrUpdateDinnerTableKey.currentState!.validate()) {
      if (_mode == ScreenType.create) {
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
