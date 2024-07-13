import 'package:freezed_annotation/freezed_annotation.dart';
part 'item_food_size_dto.freezed.dart';

@freezed
class ItemFoodSizeDTO with _$ItemFoodSizeDTO {
  factory ItemFoodSizeDTO({
    double? height,
    double? width,
  }) = _ItemFoodSizeDTO;
}
