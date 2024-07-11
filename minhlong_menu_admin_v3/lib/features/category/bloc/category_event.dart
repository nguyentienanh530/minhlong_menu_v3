part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryFetched extends CategoryEvent {
  final int? page;
  final int? limit;
  final String? type;
  CategoryFetched({this.type, this.page, this.limit});
}

final class CategoryCreated extends CategoryEvent {
  final CategoryItem categoryItem;
  CategoryCreated(this.categoryItem);
}

final class CategoryUpdated extends CategoryEvent {
  final CategoryItem categoryItem;
  CategoryUpdated(this.categoryItem);
}

final class CategoryDeleted extends CategoryEvent {
  final int categoryID;
  CategoryDeleted(this.categoryID);
}
