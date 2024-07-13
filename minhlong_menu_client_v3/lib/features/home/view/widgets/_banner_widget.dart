part of '../screens/home_view.dart';

extension _BannerWidget on _HomeViewState {
  Widget _bannerHome() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        return (switch (state) {
          BannerFetchInProgress() => const Loading(),
          BannerFetchSuccess() => ValueListenableBuilder(
              valueListenable: _indexPage,
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox.expand(
                      child: CarouselSlider.builder(
                        itemBuilder: (context, index, realIndex) {
                          return CachedNetworkImage(
                            imageUrl:
                                '${ApiConfig.host}${state.banners[index].image}',
                            fit: BoxFit.cover,
                            errorWidget: errorBuilderForImage,
                            placeholder: (context, url) => const Loading(),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            _indexPage.value = index;
                          },
                          reverse: false,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 1,
                          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                          enableInfiniteScroll: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          viewportFraction: 1,
                        ),
                        itemCount: state.banners.length,
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        child: _buildIndicator(context, state.banners.length))
                  ],
                );
              },
            ),
          BannerFetchFailure() => ErrWidget(error: state.message),
          BannerFetchEmpty() => const EmptyWidget(),
          _ => Container(),
        });
      },
    );
  }

  Widget _buildIndicator(BuildContext context, int length) {
    return AnimatedSmoothIndicator(
        activeIndex: _indexPage.value,
        count: length,
        effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.themeColor,
            dotHeight: 8,
            dotWidth: 8,
            dotColor: AppColors.white));
  }
}
