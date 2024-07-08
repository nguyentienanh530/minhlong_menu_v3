import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/repositories/food_repository.dart';

import '../data/model/food_item.dart';
import '../data/model/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

typedef Emit = Emitter<FoodState>;

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc(FoodRepository foodRepository)
      : _foodRepository = foodRepository,
        super(FoodInitial()) {
    on<FoodFetched>(_onFoodFetched);
    on<FoodCreated>(_onFoodCreated);
  }

  final FoodRepository _foodRepository;

  FutureOr<void> _onFoodFetched(FoodFetched event, Emit emit) async {
    emit(FoodFetchInProgress());
    var result =
        await _foodRepository.getFoods(page: event.page, limit: event.limit);
    result.when(success: (food) {
      if (food.foodItems.isEmpty) {
        emit(FoodFetchEmpty());
      } else {
        emit(FoodFetchSuccess(food));
      }
    }, failure: (err) {
      emit(FoodFetchFailure(err.toString()));
    });
  }

  FutureOr<void> _onFoodCreated(FoodCreated event, Emit emit) async {
    emit(FoodCreateInProgress());
    var result = await _foodRepository.createFood(food: event.food);
    result.when(success: (success) {
      emit(FoodCreateSuccess(success));
    }, failure: (message) {
      emit(FoodCreateFailure(message));
    });
  }
}
