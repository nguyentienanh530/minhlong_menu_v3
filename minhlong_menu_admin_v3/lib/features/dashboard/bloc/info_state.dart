part of 'info_bloc.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}

final class InfoFetchInProgress extends InfoState {}

final class InfoFetchFailure extends InfoState {
  final String message;

  InfoFetchFailure(this.message);
}

final class InfoFetchSuccess extends InfoState {
  final InfoModel info;

  InfoFetchSuccess(this.info);
}
