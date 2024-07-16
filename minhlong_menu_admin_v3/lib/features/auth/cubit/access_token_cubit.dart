import 'package:bloc/bloc.dart';

import '../data/model/access_token.dart';

class AccessTokenCubit extends Cubit<AccessToken> {
  AccessTokenCubit() : super(AccessToken());

  void setAccessToken(AccessToken accessToken) => emit(accessToken);
}
