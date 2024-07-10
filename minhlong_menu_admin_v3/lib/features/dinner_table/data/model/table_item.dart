import 'package:freezed_annotation/freezed_annotation.dart';
part 'table_item.freezed.dart';
part 'table_item.g.dart';

@freezed
class TableItem with _$TableItem {
  factory TableItem(
      {@Default(0) int id,
      @Default('') String name,
      @Default(0) int seats,
      @Default(false) @JsonKey(name: 'is_use') bool? isUse,
      @Default(0) @JsonKey(name: 'order_count') int? orderCount}) = _TableItem;

  factory TableItem.fromJson(Map<String, dynamic> json) =>
      _$TableItemFromJson(json);
}
