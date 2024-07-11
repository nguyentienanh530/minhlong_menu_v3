part of '../screen/table_view.dart';

extension _TableWidget on _TableViewState {
  Widget _titleTable() {
    return Text(
      AppString.chooseTable,
      style: kHeadingStyle.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _tableList(int index) {
    bool checkTable = false;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Image.asset(tableList[index].isUse
                    ? AppAsset.tableDisable
                    : AppAsset.tableEnable),
              ),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    tableList[index].name,
                    style: kBodyStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Số ghế : ${tableList[index].seats}',
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor),
                  ),
                ])),
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
