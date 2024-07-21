part of 'best_selling_food_bloc.dart';

@immutable
sealed class BestSellingFoodEvent {}

final class BestSellingFoodFetched extends BestSellingFoodEvent {}
