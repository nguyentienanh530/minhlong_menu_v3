import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/respositories/order_repository.dart';

import '../data/model/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(OrderRepository orderRespository)
      : _orderRespository = orderRespository,
        super(OrderInitial()) {
    on<OrderFetchNewOrdersStarted>(_orderFetchNewOrdersStarted);
  }

  final OrderRepository _orderRespository;

  FutureOr<void> _orderFetchNewOrdersStarted(
      OrderFetchNewOrdersStarted event, Emitter<OrderState> emit) async {
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
}
