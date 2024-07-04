part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetchNewOrdersStarted extends OrderEvent {
  final int page;
  final int limit;

  OrderFetchNewOrdersStarted({required this.page, required this.limit});
}
