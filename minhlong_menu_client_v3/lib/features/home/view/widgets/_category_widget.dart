part of '../screens/home_view.dart';

extension _CategoryWidget on _HomeViewState {
  Widget categoryListView(List<CategoryModel> categories) {
    return SizedBox(
      height: 0.2 * context.sizeDevice.height,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories
              .map(
                (e) => _buildCategoryItem(e),
              )
              .toList()),
    );
  }

  Widget _buildCategoryItem(CategoryModel categoryModel) {
    return AspectRatio(
      aspectRatio: 6.5 / 12,
      child: GestureDetector(
        onTap: () {
          context.push(AppRoute.categories, extra: categoryModel);
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
                  imageUrl: '${ApiConfig.host}${categoryModel.image}',
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
                  style: kBodyWhiteStyle.copyWith(
                      fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
