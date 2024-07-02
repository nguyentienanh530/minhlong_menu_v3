import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_model.dart';

class OrderSocketCubit extends Cubit<List<OrderModel>> {
  OrderSocketCubit() : super(<OrderModel>[]);

  void setOrderList(List<OrderModel> list) => emit(list);
}
