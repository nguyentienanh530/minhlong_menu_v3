import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/empty_screen.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/bloc/dinner_table_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_style.dart';
import '../../../dinner_table/data/repositories/table_repository.dart';
import '../../../food/bloc/search_food_bloc/search_food_bloc.dart';
import '../../../food/data/model/food_item.dart';
import '../../bloc/order_bloc.dart';
import '../../data/repositories/order_repository.dart';

class CreateOrUpdateOrderScreen extends StatelessWidget {
  const CreateOrUpdateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(context.read<OrderRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              DinnerTableBloc(context.read<DinnerTableRepository>()),
        ),
      ],
      child: const CreateOrUpdateOrderView(),
    );
  }
}

class CreateOrUpdateOrderView extends StatefulWidget {
  const CreateOrUpdateOrderView({super.key});

  @override
  State<CreateOrUpdateOrderView> createState() =>
      _CreateOrUpdateOrderViewState();
}

class _CreateOrUpdateOrderViewState extends State<CreateOrUpdateOrderView> {
  final _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? overlayEntry;
  var _overlayShown = false;
  final _order = ValueNotifier(OrderItem());
  final _table = ValueNotifier(TableItem());

  @override
  void initState() {
    super.initState();
    context.read<DinnerTableBloc>().add(AllDinnerTableFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DinnerTableBloc, DinnerTableState>(
      listener: (context, state) {
        if (state is AllDinnerTablesSuccess) {
          _table.value = state.tables.first;
        }
      },
      builder: (context, state) {
        return (switch (state) {
          AllDinnerTablesInProgress() =>
            Scaffold(appBar: AppBar(), body: const Loading()),
          AllDinnerTablesEmpty() =>
            Scaffold(appBar: AppBar(), body: const EmptyScreen()),
          AllDinnerTablesFailure() =>
            Scaffold(appBar: AppBar(), body: ErrWidget(error: state.message)),
          AllDinnerTablesSuccess() => _buildBody(state.tables),
          _ => Scaffold(
              appBar: AppBar(),
              body: const SizedBox(),
            ),
        });
      },
    );
  }

  Widget _buildTablesDropdown(List<TableItem> tables) {
    return Container(
        height: 35,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: AppColors.white,
        ),
        child: ListenableBuilder(
          listenable: _table,
          builder: (context, _) {
            return DropdownButton(
              padding: const EdgeInsets.all(0),
              value: _table.value,
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: const TextStyle(color: AppColors.secondTextColor),
              dropdownColor: AppColors.white,
              items: tables
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                _table.value = value!;
              },
            );
          },
        ));
  }

  Widget _buildSearchFoods() {
    return SizedBox(
      key: AppKeys.searchFoodsKey,
      height: 40,
      width: 400,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: CommonTextField(
          filled: true,
          hintText: 'Tìm kiếm',
          controller: _searchController,
          onChanged: (value) async {
            _searchController.text = value;
            print('overLay: $_overlayShown');
            if (value.isNotEmpty && !_overlayShown) {
              _showOverlaySearch();
              _overlayShown = true;
            }

            context
                .read<SearchFoodBloc>()
                .add(SearchFoodStarted(query: _searchController.text));
          },
          prefixIcon:
              const Icon(Icons.search, color: AppColors.secondTextColor),
          suffixIcon: InkWell(
            onTap: () {
              _searchController.clear();
              context.read<SearchFoodBloc>().add(SearchFoodReset());
            },
            child: const SizedBox(
              child: Icon(Icons.clear, color: AppColors.secondTextColor),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlaySearch() {
    final overlay = Overlay.of(context);
    final renderBox =
        AppKeys.searchFoodsKey.currentContext!.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    _hideOverlaySearch();
    assert(overlayEntry == null);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          link: _layerLink,
          child: Material(
            // adding transparent to apply custom border
            color: Colors.transparent,
            child: Card(
              elevation: 30,
              shadowColor: AppColors.lavender,
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      var state = context.watch<SearchFoodBloc>().state;

                      return (switch (state) {
                        FoodSearchInProgress() => const Loading(),
                        FoodSearchSuccess() => buildListFood(state.foodItems),
                        FoodSearchFailure() => const SizedBox(),
                        FoodSearchEmpty() => Center(
                            child: Text('Không có dữ liệu',
                                style: kBodyStyle.copyWith(
                                    color: AppColors.secondTextColor))),
                        _ => const SizedBox(),
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  buildListFood(List<FoodItem> foodItems) {
    print('state in search: $foodItems');
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return buildFoodItem(foodItems[index]);
      },
    );
  }

  buildFoodItem(FoodItem foodItem) {
    return ListTile(
      onTap: () async {
        _hideOverlaySearch();
        _searchController.clear();
        _overlayShown = false;
        var isExist = Ultils.checkExistFood(_order.value, foodItem.id);
        if (isExist) {
          OverlaySnackbar.show(context, 'Đã có trong đơn hàng!',
              type: OverlaySnackbarType.error);
          return;
        }
        var food = FoodOrderModel(
          id: foodItem.id,
          image1: foodItem.image1,
          name: foodItem.name,
          price: foodItem.price ?? 0,
          quantity: 1,
          totalAmount: AppRes.foodPrice(
            isDiscount: foodItem.isDiscount ?? false,
            foodPrice: foodItem.price ?? 0,
            discount: foodItem.discount ?? 0,
          ),
          isDiscount: foodItem.isDiscount ?? false,
          discount: foodItem.discount ?? 0,
        );

        _order.value = _order.value.copyWith(
          foodOrders: [..._order.value.foodOrders, food],
        );
        // _focusSearch.unfocus();
        // await _showCreateOrUpdateDialog(
        //     mode: FoodScreenMode.update, foodItem: foodItem);
      },
      title: Text(
        foodItem.name,
        style: kBodyStyle,
      ),
      leading: SizedBox(
        height: 35,
        width: 35,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.host}${foodItem.image1}',
            errorWidget: errorBuilderForImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _hideOverlaySearch() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;

    // _searchController.clear();
    // context.read<SearchFoodBloc>().add(SearchFoodReset());
  }

  Widget _itemFood(FoodOrderModel food) {
    final quantity = ValueNotifier(food.quantity);
    // final totalAmount = ValueNotifier(food.totalAmount);
    return Card(
      child: SizedBox(
        height: 50,
        width: context.sizeDevice.width,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConfig.host}${food.image1}',
                  placeholder: (context, url) => const Loading(),
                  errorWidget: errorBuilderForImage,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(flex: 2, child: Text(food.name)),
              Expanded(child: Text(Ultils.currencyFormat(food.price))),
              Expanded(
                  flex: 2,
                  child: ListenableBuilder(
                      listenable: quantity,
                      builder: (context, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: IconButton(
                                  iconSize: 15,
                                  alignment: Alignment.center,
                                  color: AppColors.white,
                                  style: IconButton.styleFrom(
                                      backgroundColor: AppColors.themeColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              textFieldBorderRadius))),
                                  onPressed: () {
                                    if (quantity.value > 1) {
                                      quantity.value--;
                                      context
                                          .read<OrderBloc>()
                                          .handleUpdateQuantityFood(
                                              _order.value,
                                              quantity.value,
                                              food);
                                    }
                                  },
                                  icon: const Icon(Icons.remove)),
                            ),
                            10.horizontalSpace,
                            Text(
                              quantity.value.toString(),
                              textAlign: TextAlign.center,
                            ),
                            10.horizontalSpace,
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: IconButton(
                                  iconSize: 15,
                                  alignment: Alignment.center,
                                  color: AppColors.white,
                                  style: IconButton.styleFrom(
                                      backgroundColor: AppColors.themeColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              textFieldBorderRadius))),
                                  onPressed: () {
                                    quantity.value++;
                                    context
                                        .read<OrderBloc>()
                                        .handleUpdateQuantityFood(
                                            _order.value, quantity.value, food);
                                    // _handleUpdateQuantityFood(
                                    //     quantity.value, food);
                                  },
                                  icon: const Icon(Icons.add)),
                            ),
                          ],
                        );
                      })),
              Expanded(child: Text(Ultils.currencyFormat(food.totalAmount))),
              IconButton(
                  onPressed: () {
                    _order.value = _order.value.copyWith(
                      foodOrders: _order.value.foodOrders
                          .where((element) => element.id != food.id)
                          .toList(),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _buildBody(List<TableItem> tables) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size(context.sizeDevice.width, 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [_buildSearchFoods(), _buildTablesDropdown(tables)],
                ),
                10.verticalSpace
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: context.sizeDevice.width,
              child: ListenableBuilder(
                  listenable: _order,
                  builder: (context, _) {
                    return _order.value.foodOrders.isEmpty
                        ? Center(
                            child: Text(
                              'Không có dữ liệu',
                              style: kBodyStyle.copyWith(
                                color: AppColors.secondTextColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _order.value.foodOrders.length,
                            itemBuilder: (context, index) {
                              return _itemFood(_order.value.foodOrders[index]);
                            },
                          );
                  }),
            ),
          ),
          Card(
            child: SizedBox(
              height: 100,
              width: context.sizeDevice.width,
            ),
          )
        ],
      ),
    );
  }

  // void _handleUpdateQuantityFood(int quantity, FoodOrderModel food) {
  //   int index =
  //       _order.value.foodOrders.indexWhere((element) => element.id == food.id);

  //   if (index != -1) {
  //     var existingFoodOrder = _order.value.foodOrders[index];

  //     var updatedFoodOrder = existingFoodOrder.copyWith(
  //         quantity: quantity,
  //         totalAmount: quantity *
  //             AppRes.foodPrice(
  //                 isDiscount: existingFoodOrder.isDiscount,
  //                 foodPrice: existingFoodOrder.price,
  //                 discount: int.parse(existingFoodOrder.discount.toString())));

  //     List<FoodOrderModel> updatedFoods = List.from(_order.value.foodOrders);
  //     updatedFoods[index] = updatedFoodOrder;
  //     double newTotalPrice = updatedFoods.fold(
  //         0, (double total, currentFood) => total + currentFood.totalAmount);
  //     _order.value = _order.value
  //         .copyWith(foodOrders: updatedFoods, totalPrice: newTotalPrice);
  //     // context.read<CartCubit>().setOrderModel(orderModel);
  //   } else {
  //     return;
  //   }
  // }
}
