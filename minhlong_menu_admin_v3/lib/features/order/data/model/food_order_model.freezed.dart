// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodOrderModel _$FoodOrderModelFromJson(Map<String, dynamic> json) {
  return _FoodOrderModel.fromJson(json);
}

/// @nodoc
mixin _$FoodOrderModel {
  @JsonKey(name: 'order_details_id')
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_id')
  int get foodID => throw _privateConstructorUsedError;
  String? get image1 => throw _privateConstructorUsedError;
  String? get image2 => throw _privateConstructorUsedError;
  String? get image3 => throw _privateConstructorUsedError;
  String? get image4 => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_discount')
  bool get isDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int get discount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodOrderModelCopyWith<FoodOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodOrderModelCopyWith<$Res> {
  factory $FoodOrderModelCopyWith(
          FoodOrderModel value, $Res Function(FoodOrderModel) then) =
      _$FoodOrderModelCopyWithImpl<$Res, FoodOrderModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'order_details_id') int id,
      String name,
      @JsonKey(name: 'food_id') int foodID,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String note,
      double price,
      int quantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'is_discount') bool isDiscount,
      @JsonKey(name: 'discount') int discount});
}

/// @nodoc
class _$FoodOrderModelCopyWithImpl<$Res, $Val extends FoodOrderModel>
    implements $FoodOrderModelCopyWith<$Res> {
  _$FoodOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodID = null,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? note = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
    Object? isDiscount = null,
    Object? discount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      foodID: null == foodID
          ? _value.foodID
          : foodID // ignore: cast_nullable_to_non_nullable
              as int,
      image1: freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image3: freezed == image3
          ? _value.image3
          : image3 // ignore: cast_nullable_to_non_nullable
              as String?,
      image4: freezed == image4
          ? _value.image4
          : image4 // ignore: cast_nullable_to_non_nullable
              as String?,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isDiscount: null == isDiscount
          ? _value.isDiscount
          : isDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodOrderModelImplCopyWith<$Res>
    implements $FoodOrderModelCopyWith<$Res> {
  factory _$$FoodOrderModelImplCopyWith(_$FoodOrderModelImpl value,
          $Res Function(_$FoodOrderModelImpl) then) =
      __$$FoodOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'order_details_id') int id,
      String name,
      @JsonKey(name: 'food_id') int foodID,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String note,
      double price,
      int quantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'is_discount') bool isDiscount,
      @JsonKey(name: 'discount') int discount});
}

/// @nodoc
class __$$FoodOrderModelImplCopyWithImpl<$Res>
    extends _$FoodOrderModelCopyWithImpl<$Res, _$FoodOrderModelImpl>
    implements _$$FoodOrderModelImplCopyWith<$Res> {
  __$$FoodOrderModelImplCopyWithImpl(
      _$FoodOrderModelImpl _value, $Res Function(_$FoodOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? foodID = null,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? note = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
    Object? isDiscount = null,
    Object? discount = null,
  }) {
    return _then(_$FoodOrderModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      foodID: null == foodID
          ? _value.foodID
          : foodID // ignore: cast_nullable_to_non_nullable
              as int,
      image1: freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image3: freezed == image3
          ? _value.image3
          : image3 // ignore: cast_nullable_to_non_nullable
              as String?,
      image4: freezed == image4
          ? _value.image4
          : image4 // ignore: cast_nullable_to_non_nullable
              as String?,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isDiscount: null == isDiscount
          ? _value.isDiscount
          : isDiscount // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodOrderModelImpl implements _FoodOrderModel {
  _$FoodOrderModelImpl(
      {@JsonKey(name: 'order_details_id') this.id = 0,
      this.name = '',
      @JsonKey(name: 'food_id') this.foodID = 0,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.note = '',
      this.price = 0,
      this.quantity = 0,
      @JsonKey(name: 'total_amount') this.totalAmount = 0,
      @JsonKey(name: 'is_discount') this.isDiscount = false,
      @JsonKey(name: 'discount') this.discount = 0});

  factory _$FoodOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodOrderModelImplFromJson(json);

  @override
  @JsonKey(name: 'order_details_id')
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'food_id')
  final int foodID;
  @override
  final String? image1;
  @override
  final String? image2;
  @override
  final String? image3;
  @override
  final String? image4;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'is_discount')
  final bool isDiscount;
  @override
  @JsonKey(name: 'discount')
  final int discount;

  @override
  String toString() {
    return 'FoodOrderModel(id: $id, name: $name, foodID: $foodID, image1: $image1, image2: $image2, image3: $image3, image4: $image4, note: $note, price: $price, quantity: $quantity, totalAmount: $totalAmount, isDiscount: $isDiscount, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodOrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.foodID, foodID) || other.foodID == foodID) &&
            (identical(other.image1, image1) || other.image1 == image1) &&
            (identical(other.image2, image2) || other.image2 == image2) &&
            (identical(other.image3, image3) || other.image3 == image3) &&
            (identical(other.image4, image4) || other.image4 == image4) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.isDiscount, isDiscount) ||
                other.isDiscount == isDiscount) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, foodID, image1, image2,
      image3, image4, note, price, quantity, totalAmount, isDiscount, discount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodOrderModelImplCopyWith<_$FoodOrderModelImpl> get copyWith =>
      __$$FoodOrderModelImplCopyWithImpl<_$FoodOrderModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodOrderModelImplToJson(
      this,
    );
  }
}

abstract class _FoodOrderModel implements FoodOrderModel {
  factory _FoodOrderModel(
      {@JsonKey(name: 'order_details_id') final int id,
      final String name,
      @JsonKey(name: 'food_id') final int foodID,
      final String? image1,
      final String? image2,
      final String? image3,
      final String? image4,
      final String note,
      final double price,
      final int quantity,
      @JsonKey(name: 'total_amount') final double totalAmount,
      @JsonKey(name: 'is_discount') final bool isDiscount,
      @JsonKey(name: 'discount') final int discount}) = _$FoodOrderModelImpl;

  factory _FoodOrderModel.fromJson(Map<String, dynamic> json) =
      _$FoodOrderModelImpl.fromJson;

  @override
  @JsonKey(name: 'order_details_id')
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'food_id')
  int get foodID;
  @override
  String? get image1;
  @override
  String? get image2;
  @override
  String? get image3;
  @override
  String? get image4;
  @override
  String get note;
  @override
  double get price;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'is_discount')
  bool get isDiscount;
  @override
  @JsonKey(name: 'discount')
  int get discount;
  @override
  @JsonKey(ignore: true)
  _$$FoodOrderModelImplCopyWith<_$FoodOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
