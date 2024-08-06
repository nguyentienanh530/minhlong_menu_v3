part of '../screens/home_screen.dart';

extension _Header on _HomeViewState {
  Widget _buildHeader() {
    return SizedBox(
      // height: 80.h,
      width: double.infinity,
      child: context.isMobile
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  _buildDropdown(),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      16.horizontalSpace,
                      Expanded(
                        child: _buildButtonAdd(),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSearch(),
                10.horizontalSpace,
                _buildDropdown(),
                30.horizontalSpace,
                _buildButtonAdd(),
                30.horizontalSpace,
                _buildLogoutButton(),
                30.horizontalSpace,
              ],
            ),
    );
  }

  Widget _buildSearch() {
    return SizedBox(
      key: AppKeys.searchKey,
      height: 40,
      width: 400.h,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: CommonTextField(
          filled: true,
          hintText: 'Tìm kiếm',
          controller: _searchController,
          focusNode: _focusSearch,
          onChanged: (value) async {
            _searchController.text = value;
            print('overLay: $_overlayShown');
            if (value.isNotEmpty && !_overlayShown) {
              _showOverlaySearch();
              _overlayShown = true;
            }
            if (value.isEmpty) {
            } else {
              context
                  .read<SearchUserBloc>()
                  .add(SearchUserStarted(_searchController.text));
            }
          },
          prefixIcon:
              const Icon(Icons.search, color: AppColors.secondTextColor),
          suffixIcon: InkWell(
            onTap: () {
              _searchController.clear();
              context.read<SearchUserBloc>().add(SearchUserReset());
            },
            child: const SizedBox(
              child: Icon(Icons.clear, color: AppColors.secondTextColor),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlaySearch() {
    final overlay = Overlay.of(context);
    final renderBox =
        AppKeys.searchKey.currentContext!.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    _hideOverlaySearch();
    assert(overlayEntry == null);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          link: _layerLink,
          child: Material(
            // adding transparent to apply custom border
            color: Colors.transparent,
            child: Card(
              elevation: 30,
              shadowColor: AppColors.lavender,
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      var state = context.watch<SearchUserBloc>().state;
                      print('state in search: $state');
                      return (switch (state) {
                        SearchUserInProgress() => const Loading(),
                        SearchUserSuccess() => buildListUser(state.users),
                        SearchUserFailure() => const SizedBox(),
                        SearchUserEmpty() => const Center(
                            child:
                                Text('Không có dữ liệu', style: kBodyStyle)),
                        _ => const Text('Không có dữ liệu', style: kBodyStyle),
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  Widget buildListUser(List<UserModel> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return buildUserItem(users[index]);
      },
    );
  }

  Widget buildUserItem(UserModel user) {
    return ListTile(
      onTap: () async {
        _hideOverlaySearch();
        _searchController.clear();
        // _focusSearch.unfocus();
        // await _showCreateOrUpdateDialog(
        //     mode: ScreenType.update, foodItem: foodItem);
        _showExtenedUserDialog(user);
      },
      title: Text(
        user.fullName,
        style: kBodyStyle,
      ),
      leading: SizedBox(
        height: 35,
        width: 35,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8).r,
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.host}${user.image}',
            errorWidget: errorBuilderForImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _hideOverlaySearch() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;

    // _searchController.clear();
    // context.read<SearchFoodBloc>().add(SearchFoodReset());
  }

  Widget _buildDropdown() {
    return Container(
        height: 35,
        width: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: ValueListenableBuilder(
          valueListenable: _limit,
          builder: (context, limit, child) {
            return DropdownButton(
              padding: const EdgeInsets.all(0),
              // isExpanded: true,
              value: limit.toString(),
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
              dropdownColor: AppColors.white,
              items: itemsDropdown,
              onChanged: (value) {
                _limit.value = int.parse(value.toString());
                _curentPage.value = 1;
                _fechData(page: _curentPage.value, limit: _limit.value);
              },
            );
          },
        ));
  }

  _buildButtonAdd() {
    return InkWell(
      onTap: () async {
        _showCreateOrUpdateUserDialog();
      },
      child: Container(
        height: 35,
        width: 130.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: context.colorScheme.primary,
        ),
        child: Text(
          'Thêm',
          style: kBodyStyle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  void _showCreateOrUpdateUserDialog() async {
    bool? result = await showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => UsersBloc(context.read<UserRepo>()),
        child: const CreateOrUpdateUserDialog(),
      ),
    );
    if (result != null && result) {
      _fechData(page: _curentPage.value, limit: _limit.value);
    }
  }

  void _showLogoutDialog() async {
    AppDialog.showWarningDialog(
      context,
      haveCancelButton: true,
      title: 'Đăng xuất',
      description: 'Bạn có muốn đăng xuất',
      onPressedComfirm: () {
        context.pop();
        context.read<AuthBloc>().add(AuthLogoutStarted());
      },
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: () async {
        _showLogoutDialog();
      },
      child: Container(
        height: 35,
        width: 200.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: context.colorScheme.error,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            10.horizontalSpace,
            Text(
              'Đăng xuất',
              style: kBodyStyle.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
