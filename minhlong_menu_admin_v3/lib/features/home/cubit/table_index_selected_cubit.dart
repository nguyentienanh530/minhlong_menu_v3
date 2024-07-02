import 'package:bloc/bloc.dart';

class TableIndexSelectedCubit extends Cubit<int> {
  TableIndexSelectedCubit() : super(0);

  void changeIndex(int index) => emit(index);
}
