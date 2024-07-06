import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/repositories/order_repository.dart';

import '../data/model/order_item.dart';
import '../data/model/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

typedef Emit = Emitter<OrderState>;

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(OrderRepository orderRespository)
      : _orderRespository = orderRespository,
        super(OrderInitial()) {
    on<OrderFetchNewOrdersStarted>(_orderFetchNewOrdersStarted);
    on<OrderUpdated>(_onOrderUpdated);
    on<OrderDeleted>(_onOrderDeleted);
  }

  final OrderRepository _orderRespository;

  FutureOr<void> _orderFetchNewOrdersStarted(
      OrderFetchNewOrdersStarted event, Emit emit) async {
    emit(OrderFetchNewOrdersInProgress());
    final result = await _orderRespository.getOrders(
      page: event.page,
      limit: event.limit,
      status: event.status,
    );
    result.when(
      success: (orderList) {
        if (orderList.orderItems.isEmpty) {
          emit(OrderFetchNewOrdersEmpty());
        } else {
          emit(OrderFetchNewOrdersSuccess(orderList));
        }
      },
      failure: (message) {
        emit(OrderFetchNewOrdersFailure(message));
      },
    );
  }

  FutureOr<void> _onOrderUpdated(OrderUpdated event, Emit emit) async {
    emit(OrderUpdateInProgress());
    final result = await _orderRespository.updateOrder(order: event.order);
    result.when(success: (success) {
      emit(OrderUpdateSuccess());
    }, failure: (message) {
      emit(OrderUpdateFailure(message));
    });
  }

  FutureOr<void> _onOrderDeleted(OrderDeleted event, Emit emit) async {
    emit(OrderDeleteInProgress());
    final result = await _orderRespository.delete(id: event.id);
    result.when(success: (success) {
      emit(OrderDeleteSuccess());
    }, failure: (message) {
      emit(OrderDeleteFailure(message));
    });
  }
}
