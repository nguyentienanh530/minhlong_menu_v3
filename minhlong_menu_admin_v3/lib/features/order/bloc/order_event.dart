part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetchNewOrdersStarted extends OrderEvent {}
