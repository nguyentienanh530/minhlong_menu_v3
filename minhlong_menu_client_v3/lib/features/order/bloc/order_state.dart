part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderCreateSuccess extends OrderState {}

final class OrderCreateInProgress extends OrderState {}

final class OrderCreateFailure extends OrderState {
  final String error;

  OrderCreateFailure({required this.error});
}
