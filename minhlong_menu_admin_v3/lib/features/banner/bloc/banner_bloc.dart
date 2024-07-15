import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/repositories/banner_repository.dart';

import '../data/model/banner_item.dart';
import '../data/model/banner_model.dart';

part 'banner_event.dart';
part 'banner_state.dart';

typedef Emit = Emitter<BannerState>;

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required BannerRepository bannerRepository})
      : _bannerRepository = bannerRepository,
        super(BannerInitial()) {
    on<BannerFetched>(_onBannerFetched);
    on<BannerCreated>(_onBannerCreated);
    on<BannerUpdated>(_onBannerUpdated);
    on<BannerDeleted>(_onBannerDeleted);
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

  FutureOr<void> _onBannerCreated(BannerCreated event, Emit emit) async {
    emit(BannerCreateInProgress());
    final result = await _bannerRepository.createBanner(banner: event.banner);
    result.when(
      success: (success) {
        emit(BannerCreateSuccess(success));
      },
      failure: (message) {
        emit(BannerCreateFailure(errorMessage: message));
      },
    );
  }

  FutureOr<void> _onBannerUpdated(BannerUpdated event, Emit emit) async {
    emit(BannerUpdateInProgress());
    final result = await _bannerRepository.updateBanner(banner: event.banner);
    result.when(
      success: (success) {
        emit(BannerUpdateSuccess());
      },
      failure: (message) {
        emit(BannerUpdateFailure(errorMessage: message));
      },
    );
  }

  FutureOr<void> _onBannerDeleted(BannerDeleted event, Emit emit) async {
    emit(BannerDeleteInProgress());
    final result = await _bannerRepository.deleteBanner(id: event.id);
    result.when(
      success: (success) {
        emit(BannerDeleteSuccess());
      },
      failure: (message) {
        emit(BannerDeleteFailure(errorMessage: message));
      },
    );
  }
}
