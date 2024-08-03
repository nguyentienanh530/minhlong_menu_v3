part of '../screens/dinner_table_screen.dart';

extension _HeaderDinnderTableWidget on _DinnerTableViewState {
  Widget get _headerDinnerTableWidget => SizedBox(
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
                          child: _buildButtonAddFood(),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  10.horizontalSpace,
                  _buildDropdown(),
                  30.horizontalSpace,
                  _buildButtonAddFood(),
                  30.horizontalSpace,
                ],
              ),
      );

  Widget _buildDropdown() {
    return Container(
        height: 35,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
              style: context.bodyMedium!
                  .copyWith(color: context.bodyMedium!.color),
              items: itemsDropdown,
              onChanged: (value) {
                _limit.value = int.parse(value.toString());
                _curentPage.value = 1;
                _fetchDateDinnerTable(limit: _limit.value, page: 1);
              },
            );
          },
        ));
  }

  _buildButtonAddFood() {
    return InkWell(
      onTap: () async {
        _showCreateOrUpdateDinnerTableDialog(mode: ScreenType.create);
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
          style: context.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _showCreateOrUpdateDinnerTableDialog(
      {required ScreenType mode, TableItem? tableItem}) async {
    await showDialog(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) =>
                  DinnerTableBloc(context.read<DinnerTableRepository>()),
              child: Dialog(
                child: CreateOrUpdateDinnerTableDialog(
                  action: mode,
                  tableItem: tableItem,
                ),
              ),
            )).then(
      (value) {
        if (value != null && value is bool) {
          if (value) {
            _fetchDateDinnerTable(page: _curentPage.value, limit: _limit.value);
          }
        }
      },
    );
  }
}
