part of 'banner_bloc.dart';

@immutable
sealed class BannerEvent {}

class BannerFetched extends BannerEvent {
  final int page;
  final int limit;
  final String type;
  BannerFetched({required this.page, required this.limit, required this.type});
}

class BannerDeleted extends BannerEvent {
  final int id;
  BannerDeleted({required this.id});
}

class BannerCreated extends BannerEvent {
  final BannerItem banner;
  BannerCreated({required this.banner});
}

class BannerUpdated extends BannerEvent {
  final BannerItem banner;
  BannerUpdated({required this.banner});
}
