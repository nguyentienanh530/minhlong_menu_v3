part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodFetched extends FoodEvent {}
