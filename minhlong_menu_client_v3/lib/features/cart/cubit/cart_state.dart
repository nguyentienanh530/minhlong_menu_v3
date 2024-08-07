part of 'cart_cubit.dart';

@immutable
sealed class CartState {
  final OrderModel order;

  const CartState({required this.order});
}

final class CartInitial extends CartState {
  CartInitial() : super(order: OrderModel());
}

final class AddToCartSuccess extends CartState {
  final String message;
  const AddToCartSuccess({required super.order, required this.message});
}

final class AddToCartFailure extends CartState {
  final String errorMessage;
  AddToCartFailure(this.errorMessage) : super(order: OrderModel());
}

final class AddToCartExistFailure extends CartState {
  final String errorMessage;
  const AddToCartExistFailure(this.errorMessage, {required super.order});
}

final class RemoveFromCartSuccess extends CartState {
  const RemoveFromCartSuccess(OrderModel order) : super(order: order);
}

final class UpdateCartSuccess extends CartState {
  const UpdateCartSuccess(OrderModel order) : super(order: order);
}
