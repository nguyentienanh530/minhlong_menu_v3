part of 'daily_revenue_bloc.dart';

@immutable
sealed class DailyRevenueEvent {}

final class DailyRevenueFetched extends DailyRevenueEvent {}
