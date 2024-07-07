part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {}

final class FoodFetchInProgress extends FoodState {}

final class FoodFetchEmpty extends FoodState{}

final class FoodFetchSuccess extends FoodState {
  final FoodModel foodModel;

  FoodFetchSuccess(this.foodModel);
}

final class FoodFetchFailure extends FoodState {
  final String message;

  FoodFetchFailure(this.message);
}
