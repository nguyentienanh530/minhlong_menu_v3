import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/repositories/food_repository.dart';

import '../../data/model/food_item.dart';
import '../../data/model/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

typedef Emit = Emitter<FoodState>;

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc(FoodRepository foodRepository)
      : _foodRepository = foodRepository,
        super(FoodInitial()) {
    on<FoodFetched>(_onFoodFetched);
    on<FoodCreated>(_onFoodCreated);
    on<FoodUpdated>(_onFoodUpdated);
    on<FoodDeleted>(_onFoodDeleted);
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

  FutureOr<void> _onFoodUpdated(FoodUpdated event, Emit emit) async {
    emit(FoodUpdateInProgress());
    var result = await _foodRepository.updateFood(food: event.food);
    result.when(success: (success) {
      emit(FoodUpdateSuccess());
    }, failure: (message) {
      emit(FoodUpdateFailure(message));
    });
  }

  FutureOr<void> _onFoodDeleted(FoodDeleted event, Emit emit) async {
    emit(FoodDeleteInProgress());
    var result = await _foodRepository.deleteFood(id: event.id);
    result.when(success: (success) {
      emit(FoodDeleteSuccess());
    }, failure: (message) {
      emit(FoodDeleteFailure(message));
    });
  }
}
