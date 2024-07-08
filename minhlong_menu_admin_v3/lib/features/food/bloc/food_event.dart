part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodFetched extends FoodEvent {
  final int page;
  final int limit;

  FoodFetched({required this.page, required this.limit});
}

final class FoodCreated extends FoodEvent {
  final FoodItem food;
  FoodCreated({required this.food});
}
