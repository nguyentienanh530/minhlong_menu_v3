import 'package:bloc/bloc.dart';

import '../data/dto/item_food_size_dto.dart';

class ItemSizeCubit extends Cubit<ItemFoodSizeDTO> {
  ItemSizeCubit() : super(ItemFoodSizeDTO(height: 0, width: 0));
  void setSize(ItemFoodSizeDTO size) => emit(size);
}
