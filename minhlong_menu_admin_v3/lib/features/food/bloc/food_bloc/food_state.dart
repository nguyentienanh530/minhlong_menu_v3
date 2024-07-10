part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodInitial extends FoodState {}

final class FoodFetchInProgress extends FoodState {}

final class FoodFetchEmpty extends FoodState {}

final class FoodFetchSuccess extends FoodState {
  final FoodModel foodModel;

  FoodFetchSuccess(this.foodModel);
}

final class FoodFetchFailure extends FoodState {
  final String message;

  FoodFetchFailure(this.message);
}

final class FoodCreateInProgress extends FoodState {}

final class FoodCreateSuccess extends FoodState {
  final int id;

  FoodCreateSuccess(this.id);
}

final class FoodCreateFailure extends FoodState {
  final String message;

  FoodCreateFailure(this.message);
}

final class FoodUpdateInProgress extends FoodState {}

final class FoodUpdateSuccess extends FoodState {}

final class FoodUpdateFailure extends FoodState {
  final String message;

  FoodUpdateFailure(this.message);
}

final class FoodDeleteInProgress extends FoodState {}

final class FoodDeleteSuccess extends FoodState {}

final class FoodDeleteFailure extends FoodState {
  final String message;

  FoodDeleteFailure(this.message);
}
