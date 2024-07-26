import 'package:bloc/bloc.dart';
import '../data/model/user_model.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel());

  void userChanged(UserModel userModel) => emit(userModel);
}
