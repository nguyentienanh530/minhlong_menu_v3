import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_item.freezed.dart';
part 'category_item.g.dart';

@freezed
class CategoryItem with _$CategoryItem {
  factory CategoryItem({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int serial,
    @Default('') String image,
    @Default('') @JsonKey(name: 'created_at') String? createdAt,
    @Default('') @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _CategoryItem;

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
