part of 'food_bloc.dart';

@immutable
sealed class FoodState {
  final FoodModel food;
  const FoodState(this.food);
}

final class FoodInitial extends FoodState {
  FoodInitial() : super(FoodModel());
}

final class FoodFetchInProgress extends FoodState {
  FoodFetchInProgress() : super(FoodModel());
}

final class FoodFetchSuccess extends FoodState {
  const FoodFetchSuccess({required FoodModel food}) : super(food);
}

final class FoodLoadMoreState extends FoodState {
  const FoodLoadMoreState({required FoodModel food}) : super(food);
}

final class FoodFetchFailure extends FoodState {
  final String message;
  FoodFetchFailure(this.message) : super(FoodModel());
}

final class FoodFetchEmpty extends FoodState {
  FoodFetchEmpty() : super(FoodModel());
}

final class FoodOnCategoryFetchInProgress extends FoodState {
  FoodOnCategoryFetchInProgress() : super(FoodModel());
}

final class FoodOnCategoryFetchSuccess extends FoodState {
  const FoodOnCategoryFetchSuccess({required FoodModel food}) : super(food);
}

final class FoodOnCategoryFetchFailure extends FoodState {
  final String message;
  FoodOnCategoryFetchFailure(this.message) : super(FoodModel());
}

final class FoodOnCategoryFetchEmpty extends FoodState {
  FoodOnCategoryFetchEmpty() : super(FoodModel());
}
