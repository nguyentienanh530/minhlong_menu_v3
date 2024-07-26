part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeFetchInProgress extends HomeState {}

final class HomeFetchSuccess extends HomeState {
  final HomeModel homeModel;
  HomeFetchSuccess({required this.homeModel});
}

final class HomeFetchFailure extends HomeState {
  final String message;
  HomeFetchFailure({required this.message});
}
