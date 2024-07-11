import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/category_model.dart';
import '../data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

typedef Emit = Emitter<CategoryState>;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(CategoryRepository categoryRepository)
      : _categoryRepository = categoryRepository,
        super(CategoryInitial()) {
    on<CategoryFetched>(_onCategoryFetched);
  }
  final CategoryRepository _categoryRepository;

  FutureOr<void> _onCategoryFetched(CategoryFetched event, Emit emit) async {
    emit(CategoryFetchInProgress());
    var result = await _categoryRepository.getCategories();
    result.when(
      success: (categoryList) {
        if (categoryList.isEmpty) {
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
}
