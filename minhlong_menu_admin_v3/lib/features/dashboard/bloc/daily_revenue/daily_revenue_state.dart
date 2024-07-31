part of 'daily_revenue_bloc.dart';

@immutable
sealed class DailyRevenueState {}

final class DailyRevenueInitial extends DailyRevenueState {}

final class DailyRevenueFetchInProgress extends DailyRevenueState {}

final class DailyRevenueFetchSuccess extends DailyRevenueState {
  final List<DailyRevenue> dailyRevenues;
  DailyRevenueFetchSuccess({required this.dailyRevenues});
}

final class DailyRevenueFetchFailure extends DailyRevenueState {
  final String message;
  DailyRevenueFetchFailure({required this.message});
}

final class DailyRevenueFetchEmpty extends DailyRevenueState {}
