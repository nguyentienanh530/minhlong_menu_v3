import 'package:freezed_annotation/freezed_annotation.dart';
part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
class BannerModel with _$BannerModel {
  factory BannerModel(
          {@Default(0) @JsonKey(name: 'id') int id,
          @Default('') @JsonKey(name: 'image') String image,
          @Default('') @JsonKey(name: 'created_at') String createdAt,
          @Default('') @JsonKey(name: 'updated_at') String updatedAt}) =
      _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
