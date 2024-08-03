import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user_model.dart';
import '../../../../common/model/pagination_model.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(name: 'pagination') final PaginationModel? paginationModel,
    @Default(<UserModel>[]) @JsonKey(name: 'data') List<UserModel> users,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
