part of '../screen/table_view.dart';

extension _BodyTableWidget on _TableViewState {
  Widget _tableItem(TableModel table) {
    bool checkTable = false;
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: 100,
        width: double.infinity,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Image.asset(
                  table.isUse ? AppAsset.tableDisable : AppAsset.tableEnable,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              table.name,
                              style: kBodyStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Số ghế : ${table.seats}',
                              style: kBodyStyle.copyWith(
                                  color: AppColors.secondTextColor),
                            ),
                          ),
                        ),
                        // RichText(text: '')
                        // Text(
                        //   'Số ghế : ${table.seats}',
                        //   style: kBodyStyle.copyWith(
                        //       color: AppColors.secondTextColor),
                        // ),
                      ]),
                )),
            Expanded(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: AppColors.themeColor,
                    elevation: 4,
                    backgroundColor: AppColors.themeColor,
                  ),
                  onPressed: () {},
                  child: checkTable == false
                      ? Text(
                          AppString.check,
                          style: kBodyWhiteStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          AppString.unchecked,
                          style: kBodyWhiteStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
