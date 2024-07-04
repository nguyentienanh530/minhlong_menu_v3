part of '../screens/order_screen.dart';

extension _HeaderWidget on _OrderScreenState {
  Widget get _headerWidget => SizedBox(
        height: 78.h,
        width: double.infinity,
        child: Row(
          children: [
            _buildButtonSelectTypeOrderWidget(
                title: 'Đơn hiện tại', onTap: () {}),
            10.horizontalSpace,
            _buildButtonSelectTypeOrderWidget(
                title: 'Lịch sử đơn hàng', onTap: () {}),
            const Spacer(),
            Container(
              height: 40.h,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: AppColors.white,
              ),
              child: DropdownButton(
                padding: const EdgeInsets.all(0),
                value: '10',
                icon: const Icon(Icons.arrow_drop_down),
                borderRadius: BorderRadius.circular(defaultBorderRadius).r,
                underline: const SizedBox(),
                style: const TextStyle(color: AppColors.secondTextColor),
                dropdownColor: AppColors.white,
                items: _itemsDropdown,
                onChanged: (value) {},
              ),
            ),
            20.horizontalSpace,
            InkWell(
              onTap: () {},
              child: Container(
                height: 40.h,
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  color: AppColors.red,
                ),
                child: const Text(
                  'Thêm mới',
                  style: kButtonWhiteStyle,
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildButtonSelectTypeOrderWidget({
    required String? title,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r, color: AppColors.white),
        height: 40.h,
        child: Text(
          title ?? '',
          style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
        ),
      ),
    );
  }
}
