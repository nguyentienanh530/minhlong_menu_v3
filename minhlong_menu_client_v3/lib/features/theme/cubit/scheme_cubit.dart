import 'package:bloc/bloc.dart';

class SchemeCubit extends Cubit<String> {
  SchemeCubit() : super('blueWhale');

  void changeScheme(String value) => emit(value);
}
