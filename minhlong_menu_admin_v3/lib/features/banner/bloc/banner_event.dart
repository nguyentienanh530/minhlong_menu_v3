part of 'banner_bloc.dart';

@immutable
sealed class BannerEvent {}

class BannerFetched extends BannerEvent {
  final int page;
  final int limit;
  final String type;
  BannerFetched({required this.page, required this.limit, required this.type});
}
