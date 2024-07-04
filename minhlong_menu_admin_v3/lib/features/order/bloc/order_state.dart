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
