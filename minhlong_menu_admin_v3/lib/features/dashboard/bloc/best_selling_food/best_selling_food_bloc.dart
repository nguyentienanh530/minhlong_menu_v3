import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
import '../../data/model/best_selling_food.dart';
part 'best_selling_food_event.dart';
part 'best_selling_food_state.dart';

typedef Emit = Emitter<BestSellingFoodState>;

class BestSellingFoodBloc
    extends Bloc<BestSellingFoodEvent, BestSellingFoodState> {
  BestSellingFoodBloc({required InfoRespository infoRespository})
      : _infoRespository = infoRespository,
        super(BestSellingFoodInitial()) {
    on<BestSellingFoodFetched>(_onBestSellingFoodFetched);
  }

  final InfoRespository _infoRespository;

  FutureOr<void> _onBestSellingFoodFetched(
      BestSellingFoodFetched event, Emit emit) async {
    emit(BestSellingFoodFetchInProgress());
    final result = await _infoRespository.getBestSellingFood();
    result.when(success: (bestSellingFood) {
      if (bestSellingFood.isEmpty) {
        emit(BestSellingFoodFetchEmpty());
      }
      emit(BestSellingFoodFetchSuccess(bestSellingFood));
    }, failure: (message) {
      emit(BestSellingFoodFetchFailure(message));
    });
  }
}
