import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/pagination_model.dart';

class PaginationCubit extends Cubit<PaginationModel> {
  PaginationCubit() : super(PaginationModel());

  void setPagination(PaginationModel pagination) => emit(pagination);
}
