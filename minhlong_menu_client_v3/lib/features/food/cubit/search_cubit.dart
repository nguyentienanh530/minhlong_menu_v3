import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void onSearchChange(String value) => emit(value);

  void clearSearch() => emit('');
}
