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
          color: context.colorScheme.secondary,
          margin: const EdgeInsets.only(left: 10, bottom: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 5,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.onPrimary,
                  ),
                  child: categoryModel.image.isEmpty
                      ? Container(
                          margin: const EdgeInsets.all(defaultMargin),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colorScheme.onPrimary,
                              image: const DecorationImage(
                                image: AssetImage(AppAsset.logo),
                              )),
                        )
                      : CachedNetworkImage(
                          imageUrl: '${ApiConfig.host}${categoryModel.image}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Loading(),
                          errorWidget: errorBuilderForImage,
                        ),
                ),
              ),
              5.verticalSpace,
              Expanded(
                flex: 3,
                child: Text(
                  textAlign: TextAlign.center,
                  categoryModel.name,
                  style: context.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
