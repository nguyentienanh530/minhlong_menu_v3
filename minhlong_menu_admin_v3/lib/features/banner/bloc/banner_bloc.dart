import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/repositories/banner_repository.dart';

import '../data/model/banner_model.dart';

part 'banner_event.dart';
part 'banner_state.dart';

typedef Emit = Emitter<BannerState>;

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required BannerRepository bannerRepository})
      : _bannerRepository = bannerRepository,
        super(BannerInitial()) {
    on<BannerFetched>(_onBannerFetched);
  }
  final BannerRepository _bannerRepository;

  FutureOr<void> _onBannerFetched(BannerFetched event, Emit emit) async {
    emit(BannerFetchInProgress());
    final result = await _bannerRepository.getBanners(
        limit: event.limit, page: event.page, type: event.type);
    result.when(
      success: (banner) {
        if (banner.bannerItems.isEmpty) {
          emit(BannerFetchEmpty());
        }
        emit(BannerFetchSuccess(bannerModel: banner));
      },
      failure: (String failure) {
        emit(BannerFetchFailure(errorMessage: failure));
      },
    );
  }
}
