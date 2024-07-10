import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';

class QuantityButton extends StatelessWidget {
  QuantityButton({super.key});
  final _quantity = ValueNotifier(1);
  final _totalPrice = ValueNotifier<double>(1.0);
  final double _priceFood = 0;

  @override
  Widget build(BuildContext context) {
    return _buildQuantity();
  }

  Widget _buildQuantity() {
    return ValueListenableBuilder(
        valueListenable: _quantity,
        builder: (context, quantity, child) => Center(
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius * 3),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCounter(context,
                          icon: Icons.remove,
                          iconColor: AppColors.themeColor, onTap: () {
                        decrementQuaranty();
                      }),
                      Text(quantity.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 20)),
                      _buildCounter(context,
                          icon: Icons.add,
                          colorBg: AppColors.themeColor,
                          iconColor: AppColors.white, onTap: () {
                        incrementQuaranty();
                      })
                    ]),
              ),
            ));
  }

  void decrementQuaranty() {
    if (_quantity.value > 1) {
      _quantity.value--;
      _totalPrice.value = _quantity.value * _priceFood;
    }
  }

  void incrementQuaranty() {
    _quantity.value++;
    _totalPrice.value = _quantity.value * _priceFood;
  }

  Widget _buildCounter(BuildContext context,
      {IconData? icon, Color? colorBg, Color? iconColor, Function()? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: colorBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.themeColor)),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: iconColor)));
  }
}
