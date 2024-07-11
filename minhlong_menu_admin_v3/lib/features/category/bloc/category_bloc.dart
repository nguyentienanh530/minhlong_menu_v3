import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_item.dart';
import '../data/model/category_model.dart';
import '../data/repositories/category_repository.dart';
part 'category_event.dart';
part 'category_state.dart';

typedef Emit = Emitter<CategoryState>;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial()) {
    on<CategoryFetched>(_onCategoryFetched);
    on<CategoryCreated>(_onCategoryCreated);
    on<CategoryUpdated>(_onCategoryUpdated);
    on<CategoryDeleted>(_onCategoryDeleted);
  }

  final CategoryRepository _categoryRepository;

  FutureOr<void> _onCategoryFetched(CategoryFetched event, Emit emit) async {
    emit(CategoryFetchInProgress());
    final result = await _categoryRepository.getCategories(
        type: event.type ?? 'all',
        limit: event.limit ?? 10,
        page: event.page ?? 1);
    result.when(
      success: (categoryList) {
        if (categoryList.categoryItems.isEmpty) {
          emit(CategoryFetchEmpty());
        } else {
          emit(CategoryFetchSuccess(categoryList));
        }
      },
      failure: (message) {
        emit(CategoryFetchFailure(message));
      },
    );
  }

  FutureOr<void> _onCategoryDeleted(CategoryDeleted event, Emit emit) async {
    emit(CategoryDeleteInProgress());
    final result =
        await _categoryRepository.deleteCategory(id: event.categoryID);
    result.when(
      success: (success) {
        emit(CategoryDeleteSuccess());
      },
      failure: (message) {
        emit(CategoryDeleteFailure(message));
      },
    );
  }

  FutureOr<void> _onCategoryUpdated(CategoryUpdated event, Emit emit) async {
    emit(CategoryUpdateInProgress());
    final result =
        await _categoryRepository.updateCategory(category: event.categoryItem);
    result.when(
      success: (success) {
        emit(CategoryUpdateSuccess());
      },
      failure: (message) {
        emit(CategoryUpdateFailure(message));
      },
    );
  }

  FutureOr<void> _onCategoryCreated(CategoryCreated event, Emit emit) async {
    emit(CategoryCreateInProgress());
    final result =
        await _categoryRepository.createCategory(category: event.categoryItem);
    result.when(
      success: (success) {
        emit(CategoryCreateSuccess(success));
      },
      failure: (message) {
        emit(CategoryCreateFailure(message));
      },
    );
  }
}
