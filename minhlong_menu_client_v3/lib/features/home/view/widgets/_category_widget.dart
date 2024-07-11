part of '../screens/home_view.dart';

extension _CategoryWidget on _HomeViewState {
  Widget categoryListView() {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (index) => _buildCategoryItem())),
    );
  }

  Widget _buildCategoryItem() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AspectRatio(
          aspectRatio: 7 / 12,
          child: InkWell(
            onTap: () {
              context.push(AppRoute.categories);
            },
            child: Card(
              margin: const EdgeInsets.only(left: 10, bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: AppColors.themeColor,
              elevation: 5,
              shadowColor: AppColors.themeColor,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: categoryModel.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Loading(),
                      errorWidget: errorBuilderForImage,
                    ),
                  ),
                  5.verticalSpace,
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      categoryModel.name,
                      style: kSubHeadingWhiteStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
