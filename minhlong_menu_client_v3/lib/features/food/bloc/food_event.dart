part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class FoodFetched extends FoodEvent {
  final int? page;
  final int? limit;
  final String? property;

  FoodFetched({this.page, this.limit, this.property});
}

final class FoodOnCategoryFetched extends FoodEvent {
  final int page;
  final int limit;
  final int categoryID;

  FoodOnCategoryFetched(
      {required this.page, required this.limit, required this.categoryID});
}

final class FoodLoadMore extends FoodEvent {
  final int page;
  final int? limit;

  final String? property;

  FoodLoadMore(this.limit, this.property, {required this.page});
}
