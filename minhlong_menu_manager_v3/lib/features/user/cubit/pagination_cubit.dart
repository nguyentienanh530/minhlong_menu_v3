import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/model/pagination_model.dart';

class PaginationCubit extends Cubit<PaginationModel> {
  PaginationCubit() : super(PaginationModel());

  void setPagination(PaginationModel pagination) => emit(pagination);
}
