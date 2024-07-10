part of '../screens/dashboard_screen.dart';

extension _TableWidget on _DashboardViewState {
  Widget _buildTableWidget(
      {required int index, required List<TableItem> dinnerTable}) {
    return Wrap(
        clipBehavior: Clip.hardEdge,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: dinnerTable
            .map(
              (e) => badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColors.themeColor,
                ),
                position: badges.BadgePosition.topEnd(
                  top: -10,
                  end: -5,
                ),
                showBadge: e.orderCount == 0 ? false : true,
                badgeContent: SizedBox(
                  width: 15,
                  height: 15,
                  child: Text(
                    e.orderCount.toString(),
                    textAlign: TextAlign.center,
                    style: kBodyWhiteStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                child: InkWell(
                  hoverColor: AppColors.transparent,
                  onTap: () {
                    context.read<TableIndexSelectedCubit>().changeIndex(e.id);
                    Ultils.sendSocket(_channel, 'orders', e.id);
                  },
                  child: Card(
                    elevation: 4,
                    color: AppColors.white,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: index == e.id
                            ? AppColors.themeColor
                            : AppColors.white,
                      ),
                      borderRadius: BorderRadius.circular(
                        textFieldBorderRadius,
                      ),
                    ),
                    shadowColor: AppColors.lavender,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Text(
                        e.name,
                        style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: index == e.id
                              ? AppColors.themeColor
                              : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }

// class TableWidget extends _DashboardScreenState {
//   TableWidget({super.key});
//   final orderController = Get.put(NewOrderByTableController());
//   final WebSocketClient webSocket = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Wrap(
//         clipBehavior: Clip.hardEdge,
//         alignment: WrapAlignment.start,
//         runAlignment: WrapAlignment.start,
//         crossAxisAlignment: WrapCrossAlignment.start,
//         children: controller.tableList
//             .map(
//               (e) => badges.Badge(
//                 badgeStyle: const badges.BadgeStyle(
//                   badgeColor: AppColors.themeColor,
//                 ),
//                 position: badges.BadgePosition.topEnd(
//                   top: -10,
//                   end: -5,
//                 ),
//                 showBadge: e.orderCount == 0 ? false : true,
//                 badgeContent: SizedBox(
//                   width: 15.r,
//                   height: 15.r,
//                   child: Text(
//                     e.orderCount.toString(),
//                     textAlign: TextAlign.center,
//                     style: kBodyWhiteStyle.copyWith(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 child: Obx(
//                   () => InkWell(
//                     hoverColor: AppColors.transparent,
//                     onTap: () {
//                       webSocket.changeTableSelected(e);
//                       orderController.changeOrdersOnTap(e.id);
//                     },
//                     child: Card(
//                       elevation: 4,
//                       color: AppColors.white,
//                       shape: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: webSocket.indexSelected.value == e.id
//                               ? AppColors.themeColor
//                               : AppColors.white,
//                         ),
//                         borderRadius: BorderRadius.circular(
//                           textFieldBorderRadius,
//                         ),
//                       ),
//                       shadowColor: AppColors.lavender,
//                       child: Padding(
//                         padding: const EdgeInsets.all(3.5).r,
//                         child: Text(
//                           e.name,
//                           style: kBodyStyle.copyWith(
//                             fontWeight: FontWeight.w700,
//                             color: webSocket.indexSelected.value == e.id
//                                 ? AppColors.themeColor
//                                 : AppColors.secondTextColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//             .toList(),
//       );
//     });
//   }
// }
}
