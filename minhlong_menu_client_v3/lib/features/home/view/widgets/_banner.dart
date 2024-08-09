part of '../screens/home_view.dart';

extension _BannerWidget on _HomeViewState {
  Widget _bannerHome(List<BannerModel> banners) {
    return ValueListenableBuilder(
      valueListenable: _indexPage,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider.builder(
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        '${ApiConfig.host}${banners.isEmpty ? '' : banners[index].image}',
                    errorWidget: errorBuilderForImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Loading(),
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  _indexPage.value = index;
                },
                autoPlay: true,
                autoPlayCurve: Curves.ease,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 1,
              ),
              itemCount: banners.length,
            ),
            Positioned(
              bottom: 10,
              child: _buildIndicator(
                context,
                banners.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIndicator(BuildContext context, int length) {
    return AnimatedSmoothIndicator(
        activeIndex: _indexPage.value,
        count: length,
        effect: ExpandingDotsEffect(
            activeDotColor: context.colorScheme.primary,
            dotHeight: 8,
            dotWidth: 8,
            dotColor: context.colorScheme.onPrimary));
  }
}