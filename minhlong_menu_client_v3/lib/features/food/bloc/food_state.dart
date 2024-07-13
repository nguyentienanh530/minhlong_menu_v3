part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {}

final class FoodFetchInProgress extends FoodState {}

final class FoodFetchSuccess extends FoodState {
  final FoodModel food;

  FoodFetchSuccess(this.food);
}

final class FoodFetchFailure extends FoodState {
  final String message;
  FoodFetchFailure(this.message);
}

final class FoodFetchEmpty extends FoodState {}

final class FoodOnCategoryFetchInProgress extends FoodState {}

final class FoodOnCategoryFetchSuccess extends FoodState {
  final FoodModel food;
  FoodOnCategoryFetchSuccess(this.food);
}

final class FoodOnCategoryFetchFailure extends FoodState {
  final String message;
  FoodOnCategoryFetchFailure(this.message);
}

final class FoodOnCategoryFetchEmpty extends FoodState {}
