import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/repositories/banner_repository.dart';

import '../data/model/banner_model.dart';

part 'banner_event.dart';
part 'banner_state.dart';

typedef Emit = Emitter<BannerState>;

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc(BannerRepository bannerRepository)
      : _bannerRepository = bannerRepository,
        super(BannerInitial()) {
    on<BannerFetched>(_onBannerFetched);
  }
  final BannerRepository _bannerRepository;

  FutureOr<void> _onBannerFetched(BannerFetched event, Emit emit) async {
    emit(BannerFetchInProgress());
    final result = await _bannerRepository.getBanners();
    result.when(
      success: (List<BannerModel> banners) {
        if (banners.isEmpty) {
          emit(BannerFetchEmpty());
        }
        emit(BannerFetchSuccess(banners));
      },
      failure: (String failure) {
        emit(BannerFetchFailure(failure));
      },
    );
  }
}
