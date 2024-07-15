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

final class BannerCreateInProgress extends BannerState {}

final class BannerCreateSuccess extends BannerState {
  final int? bannerId;
  BannerCreateSuccess(this.bannerId);
}

final class BannerCreateFailure extends BannerState {
  final String errorMessage;
  BannerCreateFailure({required this.errorMessage});
}

final class BannerUpdateInProgress extends BannerState {}

final class BannerUpdateSuccess extends BannerState {}

final class BannerUpdateFailure extends BannerState {
  final String errorMessage;
  BannerUpdateFailure({required this.errorMessage});
}

final class BannerDeleteInProgress extends BannerState {}

final class BannerDeleteSuccess extends BannerState {}

final class BannerDeleteFailure extends BannerState {
  final String errorMessage;
  BannerDeleteFailure({required this.errorMessage});
}
