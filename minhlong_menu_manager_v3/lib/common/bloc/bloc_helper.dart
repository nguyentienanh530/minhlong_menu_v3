import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/result.dart';
import 'generic_bloc_state.dart';

typedef Emit<T> = Emitter<GenericBlocState<T>>;

enum ApiOperation { select, create, update, delete }

mixin BlocHelper<T> {
  ApiOperation operation = ApiOperation.select;

  _checkFailureOrSuccess(Result failureOrSuccess, Emit<T> emit) {
    failureOrSuccess.when(
      failure: (String failure) {
        emit(GenericBlocState.failure(failure));
      },
      success: (_) {
        emit(GenericBlocState.success(null));
      },
    );
  }

  _apiOperationTemplate(Future<Result> apiCallback, Emit<T> emit) async {
    emit(GenericBlocState.loading());
    Result failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess, emit);
  }

  Future<void> createItem(Future<Result> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.create;
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> updateItem(Future<Result> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.update;
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> deleteItem(Future<Result> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.delete;
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> getItems(
      Future<Result<List<T>>> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.select;
    emit(GenericBlocState.loading());
    Result<List<T>> failureOrSuccess = await apiCallback;

    failureOrSuccess.when(
      failure: (String failure) async {
        emit(GenericBlocState.failure(failure));
      },
      success: (List<T> items) async {
        if (items.isEmpty) {
          emit(GenericBlocState.empty());
        } else {
          emit(GenericBlocState.success(items));
        }
      },
    );
  }
}
