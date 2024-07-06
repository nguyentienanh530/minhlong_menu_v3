import 'package:freezed_annotation/freezed_annotation.dart';
part 'info_model.freezed.dart';
part 'info_model.g.dart';

@freezed
class InfoModel with _$InfoModel {
  factory InfoModel({
    @Default(0) @JsonKey(name: 'category_count') int categoryCount,
    @Default(0) @JsonKey(name: 'order_count') int orderCount,
    @Default(0) @JsonKey(name: 'food_count') int foodCount,
    @Default(0) @JsonKey(name: 'table_count') int tableCount,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);
}