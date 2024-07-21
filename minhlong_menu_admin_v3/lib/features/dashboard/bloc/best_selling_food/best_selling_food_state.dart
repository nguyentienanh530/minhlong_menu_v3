part of 'best_selling_food_bloc.dart';

@immutable
sealed class BestSellingFoodState {}

final class BestSellingFoodInitial extends BestSellingFoodState {}

final class BestSellingFoodFetchInProgress extends BestSellingFoodState {}

final class BestSellingFoodFetchSuccess extends BestSellingFoodState {
  final List<BestSellingFood> bestSellingFoods;

  BestSellingFoodFetchSuccess(this.bestSellingFoods);
}

final class BestSellingFoodFetchFailure extends BestSellingFoodState {
  final String message;

  BestSellingFoodFetchFailure(this.message);
}

final class BestSellingFoodFetchEmpty extends BestSellingFoodState {}
