part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodFetched extends FoodEvent {
  final int? limit;
  final String property;

  FoodFetched({this.limit, required this.property});
}
