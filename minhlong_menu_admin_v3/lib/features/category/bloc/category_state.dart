part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryFetchInProgress extends CategoryState {}

final class CategoryFetchEmpty extends CategoryState {}

final class CategoryFetchSuccess extends CategoryState {
  final CategoryModel categoryModel;
  CategoryFetchSuccess(this.categoryModel);
}

final class CategoryFetchFailure extends CategoryState {
  final String message;
  CategoryFetchFailure(this.message);
}

final class CategoryCreateInProgress extends CategoryState {}

final class CategoryCreateSuccess extends CategoryState {
  final int id;
  CategoryCreateSuccess(this.id);
}

final class CategoryCreateFailure extends CategoryState {
  final String message;
  CategoryCreateFailure(this.message);
}

final class CategoryUpdateInProgress extends CategoryState {}

final class CategoryUpdateSuccess extends CategoryState {}

final class CategoryUpdateFailure extends CategoryState {
  final String message;
  CategoryUpdateFailure(this.message);
}

final class CategoryDeleteInProgress extends CategoryState {}

final class CategoryDeleteSuccess extends CategoryState {}

final class CategoryDeleteFailure extends CategoryState {
  final String message;
  CategoryDeleteFailure(this.message);
}
