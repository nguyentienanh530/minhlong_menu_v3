import 'package:freezed_annotation/freezed_annotation.dart';
part 'best_selling_food.freezed.dart';
part 'best_selling_food.g.dart';

@freezed
class BestSellingFood with _$BestSellingFood {
  factory BestSellingFood({
    @Default(0) @JsonKey(name: 'order_count') int orderCount,
    @Default('') @JsonKey(name: 'name') String name,
  }) = _BestSellingFood;

  factory BestSellingFood.fromJson(Map<String, dynamic> json) =>
      _$BestSellingFoodFromJson(json);
}
