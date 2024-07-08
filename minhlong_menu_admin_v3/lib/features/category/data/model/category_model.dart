import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int serial,
    @Default('0') String image,
    @Default('') @JsonKey(name: 'created_at') String? createdAt,
    @Default('') @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
