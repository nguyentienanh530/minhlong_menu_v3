import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/food_item.dart';
import '../../data/repositories/food_repository.dart';

part 'search_food_event.dart';
part 'search_food_state.dart';

class SearchFoodBloc extends Bloc<SearchFoodEvent, SearchFoodState> {
  SearchFoodBloc(FoodRepository foodRepository)
      : _foodRepository = foodRepository,
        super(SearchFoodInitial()) {
    on<SearchFoodStarted>(_onSearchFoodStarted);
    on<SearchFoodReset>(_onSearchFoodReset);
  }
  final FoodRepository _foodRepository;
  FutureOr<void> _onSearchFoodStarted(
      SearchFoodStarted event, Emitter<SearchFoodState> emit) async {
    emit(FoodSearchInProgress());
    var result = await _foodRepository.search(query: event.query);
    result.when(success: (foodList) {
      if (foodList.isEmpty) {
        emit(FoodSearchEmpty());
      } else {
        emit(FoodSearchSuccess(foodList));
      }
    }, failure: (message) {
      emit(FoodSearchFailure(message));
    });
  }

  FutureOr<void> _onSearchFoodReset(
      SearchFoodReset event, Emitter<SearchFoodState> emit) {
    emit(SearchFoodInitial());
  }
}
