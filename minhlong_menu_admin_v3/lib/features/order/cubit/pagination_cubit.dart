import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/common/model/pagination_model.dart';

class PaginationCubit extends Cubit<PaginationModel> {
  PaginationCubit() : super(PaginationModel());

  void setPagination(PaginationModel pagination) => emit(pagination);
}
