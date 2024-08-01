import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_detail.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';

import '../../../core/app_res.dart';
import '../../../core/utils.dart';
import '../../food/data/model/food_item.dart';
import '../../table/data/model/table_model.dart';
part 'cart_state.dart';
// class CartCubit extends Cubit<OrderModel> {
//   CartCubit() : super(OrderModel());

//   void setOrderModel(OrderModel orderModel) => emit(orderModel);

//   void addOrderItem(OrderDetail orderItem) {
//     state.orderDetail.add(orderItem);
//     emit(state);
//   }

//   void removeOrderItem(OrderDetail orderItem) {
//     List<OrderDetail> newList = List.from(state.orderDetail);
//     newList.remove(orderItem);
//     var newTotalPrice = newList.fold(
//         0, (num total, currentFood) => total + currentFood.totalAmount);

//     emit(state.copyWith(
//         orderDetail: newList,
//         totalPrice: double.parse(newTotalPrice.toString())));
//   }

//   void clearCart() {
//     emit(OrderModel());
//   }
// }
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void addToCart({required TableModel table, required FoodItem food}) {
    if (table.name.isEmpty) {
      emit(AddToCartFailure('Chưa chọn bàn'));
    } else {
      if (_checkExistFood(food.id)) {
        emit(AddToCartFailure('Món ăn đã có trong giỏ hàng.'));
      } else {
        var newFoodOrder = OrderDetail(
            foodID: food.id,
            foodImage: food.image1 ?? '',
            foodName: food.name,
            quantity: 1,
            totalAmount: Ultils.foodPrice(
                isDiscount: food.isDiscount ?? false,
                foodPrice: food.price ?? 0,
                discount: food.discount ?? 0),
            note: '',
            discount: food.discount ?? 0,
            foodPrice: food.price ?? 0,
            isDiscount: food.isDiscount ?? false);
        var newFoods = [...state.order.orderDetail, newFoodOrder];
        double newTotalPrice = newFoods.fold(
            0, (double total, currentFood) => total + currentFood.totalAmount);
        emit(
          AddToCartSuccess(
            order: state.order.copyWith(
              orderDetail: newFoods,
              totalPrice: newTotalPrice,
            ),
            message: 'Đã thêm vào giỏ hàng.',
          ),
        );
      }
    }
  }

  bool _checkExistFood(int foodID) {
    var isExist = false;
    for (OrderDetail e in state.order.orderDetail) {
      if (e.foodID == foodID) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }

  // void addOrderItem(OrderDetail orderItem) {
  //   state.order.add(orderItem);
  //   emit(state);
  // }

  void removeOrderItem(OrderDetail orderItem) {
    List<OrderDetail> newList = List.from(state.order.orderDetail);
    newList.remove(orderItem);
    var newTotalPrice = newList.fold(
        0, (num total, currentFood) => total + currentFood.totalAmount);

    emit(RemoveFromCartSuccess(state.order.copyWith(
        orderDetail: newList,
        totalPrice: double.parse(newTotalPrice.toString()))));
  }

  void handleUpdateFood(
      OrderModel orderModel, int quantity, OrderDetail foodOrder) {
    int index = orderModel.orderDetail
        .indexWhere((element) => element.foodID == foodOrder.foodID);

    if (index != -1) {
      var existingFoodOrder = orderModel.orderDetail[index];
      var updatedFoodOrder = existingFoodOrder.copyWith(
          quantity: quantity,
          totalAmount: quantity *
              AppRes.foodPrice(
                  isDiscount: existingFoodOrder.isDiscount,
                  foodPrice: existingFoodOrder.foodPrice,
                  discount: int.parse(existingFoodOrder.discount.toString())));

      List<OrderDetail> updatedFoods = List.from(orderModel.orderDetail);
      updatedFoods[index] = updatedFoodOrder;
      double newTotalPrice = updatedFoods.fold(
          0, (double total, currentFood) => total + currentFood.totalAmount);
      orderModel = orderModel.copyWith(
          orderDetail: updatedFoods, totalPrice: newTotalPrice);
      // context.read<CartCubit>().setOrderModel(orderModel);
      emit(UpdateCartSuccess(orderModel));
    } else {
      return;
    }
  }

  void clearCart() {
    emit(CartInitial());
  }
}
