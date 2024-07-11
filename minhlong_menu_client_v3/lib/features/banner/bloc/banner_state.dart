part of 'banner_bloc.dart';

sealed class BannerState {}

final class BannerInitial extends BannerState {}

final class BannerFetchInProgress extends BannerState {}

final class BannerFetchEmpty extends BannerState {}

final class BannerFetchSuccess extends BannerState {
  final List<BannerModel> banners;
  BannerFetchSuccess(this.banners);
}

final class BannerFetchFailure extends BannerState {
  final String message;
  BannerFetchFailure(this.message);
}
