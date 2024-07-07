part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodFetched extends FoodEvent {
  final int page;
  final int limit;

  FoodFetched({required this.page, required this.limit});
}
