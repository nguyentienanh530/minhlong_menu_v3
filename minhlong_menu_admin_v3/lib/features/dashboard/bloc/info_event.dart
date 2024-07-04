part of 'info_bloc.dart';

@immutable
sealed class InfoEvent {}

class InfoFetchStarted extends InfoEvent {}
