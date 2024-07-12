part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {}

final class FoodFetchInProgress extends FoodState {}

final class FoodFetchSuccess extends FoodState {
  final List<FoodModel> foods;

  FoodFetchSuccess(this.foods);
}

final class FoodFetchFailure extends FoodState {
  final String message;
  FoodFetchFailure(this.message);
}

final class FoodFetchEmpty extends FoodState {}
