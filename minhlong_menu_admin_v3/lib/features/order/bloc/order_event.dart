part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetchNewOrdersStarted extends OrderEvent {
  final int page;
  final int limit;
  final String status;

  OrderFetchNewOrdersStarted(
      {required this.status, required this.page, required this.limit});
}

final class OrderStatusUpdated extends OrderEvent {
  final int orderID;
  final String status;
  OrderStatusUpdated({required this.orderID, required this.status});
}

final class OrderUpdated extends OrderEvent {
  final OrderItem order;
  OrderUpdated({required this.order});
}

final class OrderCancelled extends OrderEvent {
  final OrderItem order;
  OrderCancelled({required this.order});
}

final class OrderDeleted extends OrderEvent {
  final int id;
  OrderDeleted({required this.id});
}

final class OrderCreated extends OrderEvent {
  final OrderItem order;
  OrderCreated(this.order);
}

final class OrderPayed extends OrderEvent {
  final OrderItem order;
  final List<int> ids;
  OrderPayed({required this.order, required this.ids});
}
