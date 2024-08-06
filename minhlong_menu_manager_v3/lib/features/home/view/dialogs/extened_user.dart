import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_manager_v3/core/app_key.dart';
import 'package:minhlong_menu_manager_v3/core/app_style.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';
import '../../../user/bloc/users_bloc/users_bloc.dart';
import '../../../user/data/model/user_model.dart';

class ExtenedUserDialog extends StatefulWidget {
  final UserModel? user;
  const ExtenedUserDialog({super.key, this.user});

  @override
  State<ExtenedUserDialog> createState() => _ExtenedUserDialogState();
}

class _ExtenedUserDialogState extends State<ExtenedUserDialog> {
  final _expiredDatePicker = ValueNotifier(DateTime.now());
  final _extendedDatePicker = ValueNotifier(DateTime.now());
  var _isUpdateOrCreate = false;
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user ?? UserModel();
    _expiredDatePicker.value = DateTime.parse(_user.expiredAt);
    _extendedDatePicker.value = DateTime.parse(_user.extendedAt);
  }

  @override
  void dispose() {
    super.dispose();
    _expiredDatePicker.dispose();
    _extendedDatePicker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Gia hạn'.toUpperCase()),
          IconButton(
              onPressed: () => context.pop(_isUpdateOrCreate),
              icon: const Icon(Icons.close))
        ],
      ),
      titleTextStyle: kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
      scrollable: true,
      content: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersExtendedSuccess) {
            _isUpdateOrCreate = true;
            context.pop();
            _reset();

            OverlaySnackbar.show(context, 'THÀNH CÔNG!');
          }
          if (state is UsersExtendedInProgress) {
            AppDialog.showLoadingDialog(context);
          }
          if (state is UsersExtendedFailure) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(text: 'Thời gian: ', style: kBodyStyle),
                  Ultils.subcriptionEndDate(_user.expiredAt) <= 0
                      ? TextSpan(
                          text: 'Hết hạn',
                          style: kBodyStyle.copyWith(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold))
                      : TextSpan(
                          text:
                              'Còn ${Ultils.subcriptionEndDate(_user.expiredAt)} ngày',
                          style: kBodyStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                ])),
                10.verticalSpace,
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(text: 'Ngày bắt đầu: ', style: kBodyStyle),
                  TextSpan(
                      text: Ultils.formatDateToString(_user.extendedAt,
                          isShort: true),
                      style: kBodyStyle.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.bold)),
                ])),
                10.verticalSpace,
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(text: 'Ngày kết thúc: ', style: kBodyStyle),
                  TextSpan(
                      text: Ultils.formatDateToString(_user.expiredAt,
                          isShort: true),
                      style: kBodyStyle.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.bold)),
                ])),
                10.verticalSpace,
                const Divider(),
                10.verticalSpace,
                _buildDatePicker(),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
      actions: [_buildExtendUserButton()],
    );
  }

  Widget _buildExtendUserButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)),
      onPressed: () => _handleExtendUser(),
      child: const Text(
        'Gia hạn',
        style: kButtonWhiteStyle,
      ),
    );
  }

  void _handleExtendUser() {
    if (_expiredDatePicker.value.isAfter(_extendedDatePicker.value)) {
      context.read<UsersBloc>().add(UsersExtended(
          userID: _user.id,
          extended: _extendedDatePicker.value.toString(),
          expired: _expiredDatePicker.value.toString()));
    } else {
      OverlaySnackbar.show(
          context, 'Ngày kết thúc phải sau ngày bắt đầu!',
          type: OverlaySnackbarType.error);
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

  void _reset() {
    _expiredDatePicker.value = DateTime.now();
    _extendedDatePicker.value = DateTime.now();
  }
}
