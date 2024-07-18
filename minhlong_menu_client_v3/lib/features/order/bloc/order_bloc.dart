import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/order_model.dart';
import '../data/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

typedef Emit = Emitter<OrderState>;

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(OrderInitial()) {
    on<OrderCreated>(_orderCreated);
  }

  final OrderRepository _orderRepository;

  FutureOr<void> _orderCreated(OrderCreated event, Emit emit) async {
    emit(OrderCreateInProgress());
    final result = await _orderRepository.createOrder(order: event.order);
    result.when(
      success: (success) {
        emit(OrderCreateSuccess());
      },
      failure: (message) {
        emit(OrderCreateFailure(error: message));
      },
    );
  }
}
