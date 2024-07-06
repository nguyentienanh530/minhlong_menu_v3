import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

typedef Emit = Emitter<FoodState>;

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<FoodFetched>(_onFoodFetched);
  }

  FutureOr<void> _onFoodFetched(FoodFetched event, Emit emit) {}
}
