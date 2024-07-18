part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderCreated extends OrderEvent {
  final OrderModel order;
  OrderCreated(this.order);
}
