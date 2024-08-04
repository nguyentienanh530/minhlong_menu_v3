import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_manager_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_manager_v3/core/app_enum.dart';
import 'package:minhlong_menu_manager_v3/core/app_key.dart';
import 'package:minhlong_menu_manager_v3/core/app_res.dart';
import 'package:minhlong_menu_manager_v3/core/app_style.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';

class CreateOrUpdateUserDialog extends StatefulWidget {
  final ScreenType screenType;
  const CreateOrUpdateUserDialog({super.key, required this.screenType});

  @override
  State<CreateOrUpdateUserDialog> createState() =>
      _CreateOrUpdateUserDialogState();
}

class _CreateOrUpdateUserDialogState extends State<CreateOrUpdateUserDialog> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _isShowPassword = ValueNotifier(false);
  late ScreenType _screenType;
  final _startDatePicker = ValueNotifier(DateTime.now());
  final _endDatePicker = ValueNotifier(DateTime.now());

  // final _listDate = [
  //   DateDto(name: '14 ngày', value: 14),
  //   DateDto(name: '1 tháng', value: 30)
  // ];
  // late final _dropdownValue = ValueNotifier(_listDate.first);

  @override
  void initState() {
    super.initState();
    _screenType = widget.screenType;
  }

  @override
  void dispose() {
    super.dispose();
    _isShowPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_screenType == ScreenType.create
          ? 'Tạo tài khoản'.toUpperCase()
          : 'Sửa tài khoản'.toUpperCase()),
      titleTextStyle: kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
      scrollable: true,
      content: Container(
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
              _buildPasswordTextField(),
              10.verticalSpace,
              _buildDatePicker(),
              10.verticalSpace,
              _buildCreateOrUpdateButton()
            ],
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
      prefixIcon: const Icon(Icons.phone),
      validator: (value) =>
          AppRes.validatePassword(value) ? null : 'Số điện thoại không hợp lệ',
    );
  }

  Widget _buildPasswordTextField() {
    return ListenableBuilder(
      listenable: _isShowPassword,
      builder: (context, _) {
        return CommonTextField(
          labelText: 'Nhập Mật khẩu',
          controller: _passwordCtrl,
          maxLines: 1,
          obscureText: !_isShowPassword.value,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          prefixIcon: const Icon(Icons.password),
          suffixIcon: GestureDetector(
            onTap: () => _isShowPassword.value = !_isShowPassword.value,
            child: Icon(
              _isShowPassword.value ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          validator: (value) => AppRes.validatePhoneNumber(value)
              ? null
              : 'Mật khẩu không hợp lệ',
        );
      },
    );
  }

  Widget _buildCreateOrUpdateButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)),
      onPressed: () => _handleCreateOrUpdate(),
      child: Text(
        _screenType == ScreenType.create ? 'Tạo' : 'Sửa',
        style: kButtonWhiteStyle,
      ),
    );
  }

  void _handleCreateOrUpdate() {
    if (AppKeys.createOrUpdateKey.currentState!.validate()) {}
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
                  listenable: _startDatePicker,
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
                                  initialDate: _startDatePicker.value,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null &&
                                  picked != _startDatePicker.value) {
                                _startDatePicker.value = picked;
                                // _curentPage.value = 1;
                                // _fetchData(
                                //     status: _listStatus[_tabController.index],
                                //     page: 1,
                                //     date: _datePicker.value.toString(),
                                //     limit: _limit.value);
                              }
                            },
                            child: Text(Ultils.formatDateToString(
                                _startDatePicker.value.toString(),
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
                  listenable: _startDatePicker,
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
                                  initialDate: _startDatePicker.value,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null &&
                                  picked != _startDatePicker.value) {
                                _startDatePicker.value = picked;
                                // _curentPage.value = 1;
                                // _fetchData(
                                //     status: _listStatus[_tabController.index],
                                //     page: 1,
                                //     date: _datePicker.value.toString(),
                                //     limit: _limit.value);
                              }
                            },
                            child: Text(Ultils.formatDateToString(
                                _startDatePicker.value.toString(),
                                isShort: true))));
                  }),
            ],
          ),
        )
      ],
    );
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
