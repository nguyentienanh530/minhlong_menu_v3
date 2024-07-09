// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return _FoodItem.fromJson(json);
}

/// @nodoc
mixin _$FoodItem {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryID => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_discount')
  bool? get isDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_show')
  bool? get isShow => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get image1 => throw _privateConstructorUsedError;
  String? get image2 => throw _privateConstructorUsedError;
  String? get image3 => throw _privateConstructorUsedError;
  String? get image4 => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodItemCopyWith<FoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemCopyWith<$Res> {
  factory $FoodItemCopyWith(FoodItem value, $Res Function(FoodItem) then) =
      _$FoodItemCopyWithImpl<$Res, FoodItem>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'category_id') int categoryID,
      @JsonKey(name: 'order_count') int orderCount,
      String description,
      int? discount,
      @JsonKey(name: 'is_discount') bool? isDiscount,
      @JsonKey(name: 'is_show') bool? isShow,
      double? price,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      @JsonKey(name: 'category_name') String categoryName});
}

/// @nodoc
class _$FoodItemCopyWithImpl<$Res, $Val extends FoodItem>
    implements $FoodItemCopyWith<$Res> {
  _$FoodItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryID = null,
    Object? orderCount = null,
    Object? description = null,
    Object? discount = freezed,
    Object? isDiscount = freezed,
    Object? isShow = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? categoryName = null,
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
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int?,
      isDiscount: freezed == isDiscount
          ? _value.isDiscount
          : isDiscount // ignore: cast_nullable_to_non_nullable
              as bool?,
      isShow: freezed == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
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
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodItemImplCopyWith<$Res>
    implements $FoodItemCopyWith<$Res> {
  factory _$$FoodItemImplCopyWith(
          _$FoodItemImpl value, $Res Function(_$FoodItemImpl) then) =
      __$$FoodItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'category_id') int categoryID,
      @JsonKey(name: 'order_count') int orderCount,
      String description,
      int? discount,
      @JsonKey(name: 'is_discount') bool? isDiscount,
      @JsonKey(name: 'is_show') bool? isShow,
      double? price,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      @JsonKey(name: 'category_name') String categoryName});
}

/// @nodoc
class __$$FoodItemImplCopyWithImpl<$Res>
    extends _$FoodItemCopyWithImpl<$Res, _$FoodItemImpl>
    implements _$$FoodItemImplCopyWith<$Res> {
  __$$FoodItemImplCopyWithImpl(
      _$FoodItemImpl _value, $Res Function(_$FoodItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryID = null,
    Object? orderCount = null,
    Object? description = null,
    Object? discount = freezed,
    Object? isDiscount = freezed,
    Object? isShow = freezed,
    Object? price = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? image1 = freezed,
    Object? image2 = freezed,
    Object? image3 = freezed,
    Object? image4 = freezed,
    Object? categoryName = null,
  }) {
    return _then(_$FoodItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryID: null == categoryID
          ? _value.categoryID
          : categoryID // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int?,
      isDiscount: freezed == isDiscount
          ? _value.isDiscount
          : isDiscount // ignore: cast_nullable_to_non_nullable
              as bool?,
      isShow: freezed == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
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
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemImpl implements _FoodItem {
  _$FoodItemImpl(
      {this.id = 0,
      this.name = '',
      @JsonKey(name: 'category_id') this.categoryID = 0,
      @JsonKey(name: 'order_count') this.orderCount = 0,
      this.description = '',
      this.discount = 0,
      @JsonKey(name: 'is_discount') this.isDiscount = false,
      @JsonKey(name: 'is_show') this.isShow = true,
      this.price = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      @JsonKey(name: 'category_name') this.categoryName = ''});

  factory _$FoodItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey(name: 'category_id')
  final int categoryID;
  @override
  @JsonKey(name: 'order_count')
  final int orderCount;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int? discount;
  @override
  @JsonKey(name: 'is_discount')
  final bool? isDiscount;
  @override
  @JsonKey(name: 'is_show')
  final bool? isShow;
  @override
  @JsonKey()
  final double? price;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final String? image1;
  @override
  final String? image2;
  @override
  final String? image3;
  @override
  final String? image4;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;

  @override
  String toString() {
    return 'FoodItem(id: $id, name: $name, categoryID: $categoryID, orderCount: $orderCount, description: $description, discount: $discount, isDiscount: $isDiscount, isShow: $isShow, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, image1: $image1, image2: $image2, image3: $image3, image4: $image4, categoryName: $categoryName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryID, categoryID) ||
                other.categoryID == categoryID) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.isDiscount, isDiscount) ||
                other.isDiscount == isDiscount) &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.image1, image1) || other.image1 == image1) &&
            (identical(other.image2, image2) || other.image2 == image2) &&
            (identical(other.image3, image3) || other.image3 == image3) &&
            (identical(other.image4, image4) || other.image4 == image4) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      categoryID,
      orderCount,
      description,
      discount,
      isDiscount,
      isShow,
      price,
      createdAt,
      updatedAt,
      image1,
      image2,
      image3,
      image4,
      categoryName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemImplCopyWith<_$FoodItemImpl> get copyWith =>
      __$$FoodItemImplCopyWithImpl<_$FoodItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemImplToJson(
      this,
    );
  }
}

abstract class _FoodItem implements FoodItem {
  factory _FoodItem(
          {final int id,
          final String name,
          @JsonKey(name: 'category_id') final int categoryID,
          @JsonKey(name: 'order_count') final int orderCount,
          final String description,
          final int? discount,
          @JsonKey(name: 'is_discount') final bool? isDiscount,
          @JsonKey(name: 'is_show') final bool? isShow,
          final double? price,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          final String? image1,
          final String? image2,
          final String? image3,
          final String? image4,
          @JsonKey(name: 'category_name') final String categoryName}) =
      _$FoodItemImpl;

  factory _FoodItem.fromJson(Map<String, dynamic> json) =
      _$FoodItemImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'category_id')
  int get categoryID;
  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  String get description;
  @override
  int? get discount;
  @override
  @JsonKey(name: 'is_discount')
  bool? get isDiscount;
  @override
  @JsonKey(name: 'is_show')
  bool? get isShow;
  @override
  double? get price;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  String? get image1;
  @override
  String? get image2;
  @override
  String? get image3;
  @override
  String? get image4;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(ignore: true)
  _$$FoodItemImplCopyWith<_$FoodItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
