import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_dto.freezed.dart';
part 'login_dto.g.dart';

@freezed
class LoginDto with _$LoginDto {
  factory LoginDto({
    @Default(0) @JsonKey(name: 'phone_number') int phoneNumber,
    @Default('') @JsonKey(name: 'password') String password,
  }) = _LoginDto;

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);
}
