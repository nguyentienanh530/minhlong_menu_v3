import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
import '../../data/model/daily_revenue.dart';
part 'daily_revenue_event.dart';
part 'daily_revenue_state.dart';

typedef Emit = Emitter<DailyRevenueState>;

class DailyRevenueBloc extends Bloc<DailyRevenueEvent, DailyRevenueState> {
  DailyRevenueBloc(this.infoRepo) : super(DailyRevenueInitial()) {
    on<DailyRevenueFetched>(_onDailyRevenueFetched);
  }

  final InfoRespository infoRepo;

  FutureOr<void> _onDailyRevenueFetched(
      DailyRevenueFetched event, Emit emit) async {
    emit(DailyRevenueFetchInProgress());
    final result = await infoRepo.getDailyRevenue();
    result.when(success: (dailyRevenue) {
      if (dailyRevenue.isEmpty) {
        emit(DailyRevenueFetchEmpty());
      }
      emit(DailyRevenueFetchSuccess(dailyRevenues: dailyRevenue));
    }, failure: (message) {
      emit(DailyRevenueFetchFailure(message: message));
    });
  }
}
