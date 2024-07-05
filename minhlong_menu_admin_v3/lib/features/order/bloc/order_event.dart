part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetchNewOrdersStarted extends OrderEvent {
  final int page;
  final int limit;
  final String status;

  OrderFetchNewOrdersStarted(
      {required this.status, required this.page, required this.limit});
}
