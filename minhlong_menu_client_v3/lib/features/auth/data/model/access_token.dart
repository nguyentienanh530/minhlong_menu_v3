import 'package:freezed_annotation/freezed_annotation.dart';
part 'access_token.freezed.dart';
part 'access_token.g.dart';

@freezed
class AccessToken with _$AccessToken {
  factory AccessToken({
    @Default('') @JsonKey(name: 'access_token') String accessToken,
    @Default('') @JsonKey(name: 'refresh_token') String refreshToken,
  }) = _AccessToken;

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);
}
