import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_manager_v3/Routes/app_route.dart';
import 'package:minhlong_menu_manager_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_manager_v3/core/extensions.dart';
import 'package:minhlong_menu_manager_v3/core/utils.dart';
import 'package:minhlong_menu_manager_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_manager_v3/features/home/view/dialogs/create_user.dart';
import 'package:minhlong_menu_manager_v3/features/user/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:minhlong_menu_manager_v3/features/user/bloc/user_bloc/user_bloc.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user_model.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/repositories/user_repository.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../../common/widget/number_pagination.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_style.dart';
import '../../../user/bloc/users_bloc/users_bloc.dart';

import '../../../user/cubit/pagination_cubit.dart';
import '../dialogs/extened_user.dart';
part '../widgets/_header.dart';
part '../widgets/_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
        BlocProvider(
          create: (context) => UsersBloc(context.read<UserRepo>()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _limit = ValueNotifier(10);
  final _curentPage = ValueNotifier(1);
  final _listTitleTable = [
    'Hình ảnh',
    'Tên',
    'SĐT',
    'email',
    'Địa chỉ',
    'Hạn sử dụng',
    'Ngày hết hạn',
    'Hành động'
  ];
  final _user = ValueNotifier(User());
  late TextEditingController _searchController;
  final _focusSearch = FocusNode();
  OverlayEntry? overlayEntry;
  final _layerLink = LayerLink();
  var _overlayShown = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fechData(page: _curentPage.value, limit: _limit.value);
  }

  @override
  void dispose() {
    super.dispose();
    _limit.dispose();
    _curentPage.dispose();
    _user.dispose();
    _searchController.dispose();
    _focusSearch.dispose();
  }

  void _fechData({required int page, required int limit}) {
    context.read<UsersBloc>().add(UsersFetched(page: page, limit: limit));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_overlayShown) {
          _overlayShown = false;
          _hideOverlaySearch();
          overlayEntry?.remove();
        }
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserFecthFailure) {
                  context.read<AuthBloc>().add(AuthLogoutStarted());
                }
                if (state is UserFecthSuccess) {
                  if (state.user.role != 'admin') {
                    AppDialog.showErrorDialog(context,
                        description:
                            'Bạn không có quyền truy cập trang này',
                        confirmText: 'Xác nhận', onPressedComfirm: () {
                      context.read<AuthBloc>().add(AuthLogoutStarted());
                    });
                  }
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLogoutSuccess) {
                  context.read<AuthBloc>().add(AuthAuthenticateStarted());
                  context.go(AppRoute.login);
                }
              },
            ),
            BlocListener<UsersBloc, UsersState>(
              listener: (context, state) {
                if (state is UsersDeleteInProgress) {
                  AppDialog.showLoadingDialog(context);
                }
                if (state is UsersDeleteFailure) {
                  pop(context, 1);
                  OverlaySnackbar.show(context, state.errorMessage,
                      type: OverlaySnackbarType.error);
                }
                if (state is UsersDeleteSuccess) {
                  pop(context, 1);
                  OverlaySnackbar.show(context, 'Thao tác thành công',
                      type: OverlaySnackbarType.success);
                }
              },
            ),
          ],
          child: Column(
            children: [
              10.verticalSpace,
              _buildHeader(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20).r,
                child: _buildBody(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}