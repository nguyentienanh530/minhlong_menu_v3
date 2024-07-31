import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  void changeTheme(bool theme) => emit(theme);
}
