part of '../screens/home_view.dart';

extension _BannerWidget on _HomeViewState {
  Widget _bannerHome() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        return (switch (state) {
          BannerFetchInProgress() => const Loading(),
          BannerFetchSuccess() => CarouselSlider.builder(
              itemBuilder: (context, index, realIndex) {
                return CachedNetworkImage(
                  imageUrl: '${ApiConfig.host}${state.banners[index].image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: errorBuilderForImage,
                  placeholder: (context, url) => const Loading(),
                );
              },
              options: CarouselOptions(
                reverse: false,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 1,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 1,
              ),
              itemCount: state.banners.length,
            ),
          BannerFetchFailure() => ErrWidget(error: state.message),
          BannerFetchEmpty() => const EmptyWidget(),
          _ => Container(),
        });
      },
    );
  }
}
