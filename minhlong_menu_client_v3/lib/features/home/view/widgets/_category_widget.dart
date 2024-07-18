part of '../screens/home_view.dart';

extension _CategoryWidget on _HomeViewState {
  Widget categoryListView() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return (switch (state) {
            CategoryFetchInProgress() => const Loading(),
            CategoryFetchSuccess() => ListView(
                scrollDirection: Axis.horizontal,
                children: state.categories
                    .map(
                      (e) => _buildCategoryItem(e),
                    )
                    .toList()),
            CategoryFetchFailure() => ErrWidget(error: state.message),
            CategoryFetchEmpty() => const EmptyWidget(),
            _ => const SizedBox(),
          });
        },
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel categoryModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
      },
    );
  }
}
