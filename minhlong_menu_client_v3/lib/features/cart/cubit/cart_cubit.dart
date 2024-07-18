import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_detail.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';

class CartCubit extends Cubit<OrderModel> {
  CartCubit() : super(OrderModel());

  void setOrderModel(OrderModel orderModel) => emit(orderModel);

  void addOrderItem(OrderDetail orderItem) {
    state.orderDetail.add(orderItem);
    emit(state);
  }

  void removeOrderItem(OrderDetail orderItem) {
    List<OrderDetail> newList = List.from(state.orderDetail);
    newList.remove(orderItem);
    emit(state.copyWith(orderDetail: newList));
  }

  void clearCart() {
    emit(OrderModel());
  }
}
