import 'package:bloc/bloc.dart';

import 'package:minhlong_menu_client_v3/features/user/data/model/user_model.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit() : super(UserModel());

  void userChanged(UserModel userModel) => emit(userModel);
}
