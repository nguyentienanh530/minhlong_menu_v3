import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/empty_screen.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/bloc/dinner_table_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/dto/status_dto.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/common_text_field.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_enum.dart';
import '../../../../core/app_key.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_style.dart';
import '../../../dinner_table/data/repositories/table_repository.dart';
import '../../../food/bloc/search_food_bloc/search_food_bloc.dart';
import '../../../food/data/model/food_item.dart';
import '../../bloc/order_bloc.dart';
import '../../data/repositories/order_repository.dart';

class CreateOrUpdateOrderScreen extends StatelessWidget {
  const CreateOrUpdateOrderScreen({super.key, this.order, required this.type});
  final OrderItem? order;
  final ScreenType type;

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
      child: CreateOrUpdateOrderView(order: order, type: type),
    );
  }
}

class CreateOrUpdateOrderView extends StatefulWidget {
  const CreateOrUpdateOrderView({super.key, this.order, required this.type});
  final OrderItem? order;
  final ScreenType type;

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
  var _isUpdated = false;

  late ScreenType _typeScreen;
  final _listStatus = [
    StatusDto(key: 'new', value: 'Đơn mới'),
    StatusDto(key: 'processing', value: 'Đang làm'),
    StatusDto(key: 'completed', value: 'Hoàn thành'),
    StatusDto(key: 'cancel', value: 'Đơn đã huỷ'),
  ];
  late final _status = ValueNotifier(_listStatus.first);
  @override
  void initState() {
    super.initState();
    _typeScreen = widget.type;
    context.read<DinnerTableBloc>().add(AllDinnerTableFetched());
    if (widget.order != null) {
      _order.value = widget.order!;
      _status.value = _listStatus
          .firstWhere((element) => element.key == _order.value.status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(_isUpdated),
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text(_typeScreen == ScreenType.create ? 'Tạo đơn' : 'Sửa đơn',
            style: kHeadingStyle),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_overlayShown) {
            _hideOverlaySearch();
            _overlayShown = false;
          }
        },
        child: BlocConsumer<DinnerTableBloc, DinnerTableState>(
          listener: (context, state) {
            if (state is AllDinnerTablesSuccess) {
              if (widget.order != null) {
                _table.value = state.tables.firstWhere(
                    (element) => element.id == widget.order!.tableId);
              } else {
                _table.value = state.tables.first;
              }
            }
          },
          builder: (context, state) {
            return (switch (state) {
              AllDinnerTablesInProgress() => const Loading(),
              AllDinnerTablesEmpty() => const EmptyScreen(),
              AllDinnerTablesFailure() => ErrWidget(error: state.message),
              AllDinnerTablesSuccess() => _buildBody(state.tables),
              _ => Scaffold(
                  appBar: AppBar(),
                  body: const SizedBox(),
                ),
            });
          },
        ),
      ),
    );
  }

  Widget _buildTablesDropdown(List<TableItem> tables) {
    return Row(
      children: [
        const Text('Chọn bàn: ', style: kBodyStyle),
        ListenableBuilder(
          listenable: _table,
          builder: (context, _) {
            return DropdownButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              value: _table.value,
              icon: const Icon(Icons.arrow_drop_down),
              // borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: kBodyStyle.copyWith(fontWeight: FontWeight.w900),
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
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Row(
      children: [
        const Text('Trạng thái: ', style: kBodyStyle),
        ListenableBuilder(
          listenable: _status,
          builder: (context, _) {
            return DropdownButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              value: _status.value,
              icon: const Icon(Icons.arrow_drop_down),
              // borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: kBodyStyle.copyWith(fontWeight: FontWeight.w900),
              dropdownColor: AppColors.white,
              items: _listStatus
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                _status.value = value!;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchFoods() {
    return Container(
      key: AppKeys.searchFoodsKey,
      height: 40,
      constraints: const BoxConstraints(maxWidth: 300),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: CommonTextField(
          filled: true,
          hintText: 'Tìm kiếm',
          controller: _searchController,
          onChanged: (value) async {
            _searchController.text = value;

            if (value.isEmpty && _overlayShown) return;

            _showOverlaySearch();
            _overlayShown = true;

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
                            child: Text(
                              'Không có dữ liệu',
                              style: kBodyStyle.copyWith(
                                color: AppColors.secondTextColor,
                              ),
                            ),
                          ),
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

  Widget buildListFood(List<FoodItem> foodItems) {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return buildFoodItem(foodItems[index]);
      },
    );
  }

  Widget buildFoodItem(FoodItem foodItem) {
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
          totalPrice: _order.value.totalPrice + food.totalAmount,
          foodOrders: [..._order.value.foodOrders, food],
        );
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
  }

  Widget _itemFood(FoodOrderModel food) {
    final quantity = ValueNotifier(food.quantity);

    return Card(
      child: SizedBox(
        height: 50,
        width: context.sizeDevice.width,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
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
                                  _handleUpdateQuantityFood(
                                      quantity.value, food);
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

                                _handleUpdateQuantityFood(quantity.value, food);
                              },
                              icon: const Icon(Icons.add)),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: Text(
                  Ultils.currencyFormat(food.totalAmount),
                ),
              ),
              IconButton(
                onPressed: () {
                  _order.value = _order.value.copyWith(
                    foodOrders: _order.value.foodOrders
                        .where((element) => element.id != food.id)
                        .toList(),
                  );
                  var newTotal = _order.value.foodOrders.fold(
                      0,
                      (num total, currentFood) =>
                          total + currentFood.totalAmount);

                  _order.value = _order.value
                      .copyWith(totalPrice: double.parse(newTotal.toString()));
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<TableItem> tables) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        switch (state) {
          case OrderCreateInProgress():
            AppDialog.showLoadingDialog(context);
            break;
          case OrderCreateFailure():
            context.pop();
            OverlaySnackbar.show(context, state.error,
                type: OverlaySnackbarType.error);
            _isUpdated = false;
            break;
          case OrderCreateSuccess():
            pop(context, 1);
            _order.value = _order.value.copyWith(
              foodOrders: [],
              totalPrice: 0,
            );
            _isUpdated = true;
            OverlaySnackbar.show(context, 'Tạo đơn thành công');
            break;
          default:
            _isUpdated = false;
            break;
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Column(
              children: [
                context.isMobile
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            10.verticalSpace,
                            _buildSearchFoods(),
                            10.horizontalSpace,
                            _buildTablesDropdown(tables),
                            10.horizontalSpace,
                            _buildStatusDropdown(),
                            10.horizontalSpace,
                          ])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildSearchFoods(),
                          10.horizontalSpace,
                          _buildTablesDropdown(tables),
                          10.horizontalSpace,
                          _buildStatusDropdown()
                        ],
                      ),
              ],
            ),
          ),
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
            margin: const EdgeInsets.all(defaultPadding / 2),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(defaultPadding / 2),
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền',
                          style:
                              kBodyStyle.copyWith(fontWeight: FontWeight.w900),
                        ),
                        ListenableBuilder(
                          listenable: _order,
                          builder: (context, _) {
                            return Text(
                              Ultils.currencyFormat(_order.value.totalPrice),
                              style: kBodyStyle.copyWith(
                                  fontWeight: FontWeight.w900),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListenableBuilder(
                      listenable: _order,
                      builder: (context, _) {
                        return InkWell(
                          onTap: _order.value.foodOrders.isEmpty
                              ? null
                              : () {
                                  AppDialog.showErrorDialog(
                                    context,
                                    title: 'Lên đơn nhó!',
                                    confirmText: 'Ừ! lên đi',
                                    cancelText: 'Thôi!',
                                    haveCancelButton: true,
                                    onPressedComfirm: () {
                                      _handleCreateOrder(
                                          _order.value, _table.value);
                                    },
                                  );
                                },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _order.value.foodOrders.isEmpty
                                  ? AppColors.darkGray
                                  : AppColors.themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(textFieldBorderRadius),
                              ),
                            ),
                            child: const Text(
                              'Tạo đơn',
                              style: kButtonWhiteStyle,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleCreateOrder(OrderItem order, TableItem table) {
    context.pop();
    order = order.copyWith(tableId: table.id, tableName: table.name);
    context.read<OrderBloc>().add(OrderCreated(order));
  }

  void _handleUpdateQuantityFood(int quantity, FoodOrderModel food) {
    int index =
        _order.value.foodOrders.indexWhere((element) => element.id == food.id);

    if (index != -1) {
      var existingFoodOrder = _order.value.foodOrders[index];

      var updatedFoodOrder = existingFoodOrder.copyWith(
          quantity: quantity,
          totalAmount: quantity *
              AppRes.foodPrice(
                  isDiscount: existingFoodOrder.isDiscount,
                  foodPrice: existingFoodOrder.price,
                  discount: int.parse(existingFoodOrder.discount.toString())));

      List<FoodOrderModel> updatedFoods = List.from(_order.value.foodOrders);
      updatedFoods[index] = updatedFoodOrder;
      double newTotalPrice = updatedFoods.fold(
          0, (double total, currentFood) => total + currentFood.totalAmount);
      _order.value = _order.value
          .copyWith(foodOrders: updatedFoods, totalPrice: newTotalPrice);
      // context.read<CartCubit>().setOrderModel(orderModel);
    } else {
      return;
    }
  }
}
