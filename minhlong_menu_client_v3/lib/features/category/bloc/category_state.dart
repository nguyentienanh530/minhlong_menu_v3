part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryFetchInProgress extends CategoryState {}

final class CategoryFetchSuccess extends CategoryState {
  final List<CategoryModel> categories;
  CategoryFetchSuccess(this.categories);
}

final class CategoryFetchFailure extends CategoryState {
  final String message;
  CategoryFetchFailure(this.message);
}

final class CategoryFetchEmpty extends CategoryState {}
