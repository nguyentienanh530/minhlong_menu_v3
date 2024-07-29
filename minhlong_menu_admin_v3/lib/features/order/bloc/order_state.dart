part of 'order_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderFetchNewOrdersInProgress extends OrderState {}

final class OrderFetchNewOrdersEmpty extends OrderState {}

final class OrderFetchNewOrdersSuccess extends OrderState {
  final OrderModel orders;
  OrderFetchNewOrdersSuccess(this.orders);
}

final class OrderFetchNewOrdersFailure extends OrderState {
  final String message;
  OrderFetchNewOrdersFailure(this.message);
}

//===== update order =====
final class OrderUpdateInProgress extends OrderState {}

final class OrderUpdateSuccess extends OrderState {}

final class OrderUpdateFailure extends OrderState {
  final String message;
  OrderUpdateFailure(this.message);
}

//===== delete order =====
final class OrderDeleteInProgress extends OrderState {}

final class OrderDeleteSuccess extends OrderState {}

final class OrderDeleteFailure extends OrderState {
  final String message;
  OrderDeleteFailure(this.message);
}

// ===== create order =====
final class OrderCreateSuccess extends OrderState {}

final class OrderCreateInProgress extends OrderState {}

final class OrderCreateFailure extends OrderState {
  final String error;

  OrderCreateFailure({required this.error});
}
