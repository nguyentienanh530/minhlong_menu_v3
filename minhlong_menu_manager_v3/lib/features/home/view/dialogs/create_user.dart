import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_manager_v3/common/widget/common_text_field.dart';

import 'package:minhlong_menu_manager_v3/core/app_key.dart';
import 'package:minhlong_menu_manager_v3/core/app_res.dart';
import 'package:minhlong_menu_manager_v3/core/app_style.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user_model.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';
import '../../../user/bloc/users_bloc/users_bloc.dart';

class CreateOrUpdateUserDialog extends StatefulWidget {
  const CreateOrUpdateUserDialog({super.key});

  @override
  State<CreateOrUpdateUserDialog> createState() =>
      _CreateOrUpdateUserDialogState();
}

class _CreateOrUpdateUserDialogState extends State<CreateOrUpdateUserDialog> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final _isShowPassword = ValueNotifier(false);
  final _expiredDatePicker = ValueNotifier(DateTime.now());
  final _extendedDatePicker = ValueNotifier(DateTime.now());
  var _isUpdateOrCreate = false;

  // final _listDate = [
  //   DateDto(name: '14 ngày', value: 14),
  //   DateDto(name: '1 tháng', value: 30)
  // ];
  // late final _dropdownValue = ValueNotifier(_listDate.first);

  @override
  void dispose() {
    super.dispose();
    _isShowPassword.dispose();
    _expiredDatePicker.dispose();
    _extendedDatePicker.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Tạo tài khoản'.toUpperCase()),
          IconButton(
              onPressed: () => context.pop(_isUpdateOrCreate),
              icon: const Icon(Icons.close))
        ],
      ),
      titleTextStyle: kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
      scrollable: true,
      content: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersCreateSuccess) {
            _isUpdateOrCreate = true;
            context.pop();
            _reset();

            OverlaySnackbar.show(context, 'THÀNH CÔNG!');
          }
          if (state is UsersCreateInProgress) {
            AppDialog.showLoadingDialog(context);
          }
          if (state is UsersCreateFailure) {
            _isUpdateOrCreate = false;
            context.pop();
            OverlaySnackbar.show(context, state.errorMessage,
                type: OverlaySnackbarType.error);
          }
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: Form(
            key: AppKeys.createOrUpdateKey,
            child: Column(
              children: [
                10.verticalSpace,
                _buildNameTextField(),
                10.verticalSpace,
                _buildPhoneTextField(),
                10.verticalSpace,
                _buildDatePicker(),
                10.verticalSpace,
                _buildCreateOrUpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return CommonTextField(
      labelText: 'Nhập tên',
      controller: _nameCtrl,
      prefixIcon: const Icon(Icons.person),
      validator: (value) => value!.isEmpty ? 'Tên không để trống' : null,
    );
  }

  Widget _buildPhoneTextField() {
    return CommonTextField(
      labelText: 'Nhập SĐT',
      controller: _phoneCtrl,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: const Icon(Icons.phone),
      validator: (value) => AppRes.validatePhoneNumber(value)
          ? null
          : 'Số điện thoại không hợp lệ',
    );
  }

  Widget _buildCreateOrUpdateButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)),
      onPressed: () => _handleCreateOrUpdate(),
      child: const Text(
        'Tạo',
        style: kButtonWhiteStyle,
      ),
    );
  }

  void _handleCreateOrUpdate() {
    if (AppKeys.createOrUpdateKey.currentState!.validate()) {
      var user = UserModel(
        fullName: _nameCtrl.text,
        phoneNumber: int.parse(_phoneCtrl.text),
        expiredAt: _expiredDatePicker.value.toString(),
      );
      _createUser(user);
    }
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bắt đầu', style: kBodyStyle),
              5.verticalSpace,
              ListenableBuilder(
                  listenable: _extendedDatePicker,
                  builder: (context, _) {
                    return Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(textFieldBorderRadius).r,
                            border: Border.all(color: AppColors.black),
                            color: AppColors.white),
                        child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  locale: const Locale('vi'),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendar,
                                  initialDate: _extendedDatePicker.value,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null &&
                                  picked != _extendedDatePicker.value) {
                                _extendedDatePicker.value = picked;
                                // _curentPage.value = 1;
                                // _fetchData(
                                //     status: _listStatus[_tabController.index],
                                //     page: 1,
                                //     date: _datePicker.value.toString(),
                                //     limit: _limit.value);
                              }
                            },
                            child: Text(Ultils.formatDateToString(
                                _extendedDatePicker.value.toString(),
                                isShort: true))));
                  }),
            ],
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Kết thúc', style: kBodyStyle),
              5.verticalSpace,
              ListenableBuilder(
                  listenable: _expiredDatePicker,
                  builder: (context, _) {
                    return Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(textFieldBorderRadius).r,
                            border: Border.all(color: AppColors.black),
                            color: AppColors.white),
                        child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  locale: const Locale('vi'),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendar,
                                  initialDate: _expiredDatePicker.value,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null &&
                                  picked != _expiredDatePicker.value) {
                                _expiredDatePicker.value = picked;
                                // _curentPage.value = 1;
                                // _fetchData(
                                //     status: _listStatus[_tabController.index],
                                //     page: 1,
                                //     date: _datePicker.value.toString(),
                                //     limit: _limit.value);
                              }
                            },
                            child: Text(Ultils.formatDateToString(
                                _expiredDatePicker.value.toString(),
                                isShort: true))));
                  }),
            ],
          ),
        )
      ],
    );
  }

  void _createUser(UserModel user) {
    context.read<UsersBloc>().add(UsersCreated(userModel: user));
  }

  void _reset() {
    _nameCtrl.clear();
    _phoneCtrl.clear();

    _expiredDatePicker.value = DateTime.now();
    _extendedDatePicker.value = DateTime.now();
    _isShowPassword.value = false;
  }

  // Widget _buildDropdownDate() {
  //   return ListenableBuilder(
  //     listenable: _dropdownValue,
  //     builder: (context, _) {
  //       return DropdownButton(
  //         value: _dropdownValue.value,
  //         items: _listDate
  //             .map(
  //               (e) => DropdownMenuItem(
  //                 value: e,
  //                 child: Text(e.name),
  //               ),
  //             )
  //             .toList(),
  //         onChanged: (value) {
  //           _dropdownValue.value = value!;
  //         },
  //       );
  //     },
  //   );
  // }
}
