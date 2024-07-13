part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerFetchInProgress extends BannerState {}

final class BannerFetchSuccess extends BannerState {
  final BannerModel bannerModel;
  BannerFetchSuccess({required this.bannerModel});
}

final class BannerFetchFailure extends BannerState {
  final String errorMessage;
  BannerFetchFailure({required this.errorMessage});
}

final class BannerFetchEmpty extends BannerState {}
