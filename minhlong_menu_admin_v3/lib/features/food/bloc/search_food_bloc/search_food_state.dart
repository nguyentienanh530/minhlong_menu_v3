part of 'search_food_bloc.dart';

@immutable
sealed class SearchFoodState {}

final class SearchFoodInitial extends SearchFoodState {}

final class FoodSearchInProgress extends SearchFoodState {}

final class FoodSearchEmpty extends SearchFoodState {}

final class FoodSearchSuccess extends SearchFoodState {
  final List<FoodItem> foodItems;

  FoodSearchSuccess(this.foodItems);
}

final class FoodSearchFailure extends SearchFoodState {
  final String message;

  FoodSearchFailure(this.message);
}
