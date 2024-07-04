import 'package:bloc/bloc.dart';

import '../data/model/order_item.dart';

class OrderSocketCubit extends Cubit<List<OrderItem>> {
  OrderSocketCubit() : super(<OrderItem>[]);

  void setOrderList(List<OrderItem> list) => emit(list);
}
