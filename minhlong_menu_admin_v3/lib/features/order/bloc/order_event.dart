part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetchNewOrdersStarted extends OrderEvent {
  final int page;
  final int limit;
  final String status;

  OrderFetchNewOrdersStarted(
      {required this.status, required this.page, required this.limit});
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
