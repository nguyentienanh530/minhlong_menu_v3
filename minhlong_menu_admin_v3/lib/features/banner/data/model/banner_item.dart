import 'package:freezed_annotation/freezed_annotation.dart';
part 'banner_item.freezed.dart';
part 'banner_item.g.dart';

@freezed
class BannerItem with _$BannerItem {
  factory BannerItem({
    @Default(0) int id,
    @Default('') String image,
    final bool? show,
    @Default('') @JsonKey(name: 'created_at') String? createdAt,
    @Default('') @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _BannerItem;

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);
}
