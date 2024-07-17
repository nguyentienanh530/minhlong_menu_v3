import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';

import '../data/model/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc({required FoodRepository foodRepository})
      : _foodRepository = foodRepository,
        super(FoodInitial()) {
    on<FoodFetched>(_onFoodFetched);
    on<FoodOnCategoryFetched>(_onFoodOnCategoryFetched);
  }

  final FoodRepository _foodRepository;

  FutureOr<void> _onFoodFetched(
      FoodFetched event, Emitter<FoodState> emit) async {
    emit(FoodFetchInProgress());
    final result = await _foodRepository.getFoods(
      page: event.page,
      limit: event.limit,
      property: event.property,
    );
    result.when(
      success: (FoodModel food) {
        if (food.foodItems.isEmpty) {
          emit(FoodFetchEmpty());
        } else {
          emit(FoodFetchSuccess(food));
        }
      },
      failure: (String failure) {
        emit(FoodFetchFailure(failure));
      },
    );
  }

  FutureOr<void> _onFoodOnCategoryFetched(
      FoodOnCategoryFetched event, Emitter<FoodState> emit) async {
    emit(FoodOnCategoryFetchInProgress());
    final result = await _foodRepository.getFoodsOnCategory(
      limit: event.limit,
      page: event.page,
      categoryID: event.categoryID,
    );
    result.when(
      success: (FoodModel food) {
        if (food.foodItems.isEmpty) {
          emit(FoodOnCategoryFetchEmpty());
        } else {
          emit(FoodOnCategoryFetchSuccess(food));
        }
      },
      failure: (String failure) {
        emit(FoodOnCategoryFetchFailure(failure));
      },
    );
  }
}
