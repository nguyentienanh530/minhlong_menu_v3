part of 'search_food_bloc.dart';

@immutable
sealed class SearchFoodEvent {}

final class SearchFoodStarted extends SearchFoodEvent {
  final String query;
  SearchFoodStarted({required this.query});
}

final class SearchFoodReset extends SearchFoodEvent {}
