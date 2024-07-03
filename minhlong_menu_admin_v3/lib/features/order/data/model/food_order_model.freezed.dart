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
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_gallery', fromJson: stringToList)
  List<dynamic> get photoGallery => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;

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
      {String name,
      @JsonKey(name: 'photo_gallery', fromJson: stringToList)
      List<dynamic> photoGallery,
      String note,
      double price,
      int quantity,
      @JsonKey(name: 'total_amount') double totalAmount});
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
    Object? name = null,
    Object? photoGallery = null,
    Object? note = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoGallery: null == photoGallery
          ? _value.photoGallery
          : photoGallery // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
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
      {String name,
      @JsonKey(name: 'photo_gallery', fromJson: stringToList)
      List<dynamic> photoGallery,
      String note,
      double price,
      int quantity,
      @JsonKey(name: 'total_amount') double totalAmount});
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
    Object? name = null,
    Object? photoGallery = null,
    Object? note = null,
    Object? price = null,
    Object? quantity = null,
    Object? totalAmount = null,
  }) {
    return _then(_$FoodOrderModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoGallery: null == photoGallery
          ? _value._photoGallery
          : photoGallery // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodOrderModelImpl implements _FoodOrderModel {
  _$FoodOrderModelImpl(
      {this.name = '',
      @JsonKey(name: 'photo_gallery', fromJson: stringToList)
      final List<dynamic> photoGallery = const [],
      this.note = '',
      this.price = 0,
      this.quantity = 0,
      @JsonKey(name: 'total_amount') this.totalAmount = 0})
      : _photoGallery = photoGallery;

  factory _$FoodOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodOrderModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<dynamic> _photoGallery;
  @override
  @JsonKey(name: 'photo_gallery', fromJson: stringToList)
  List<dynamic> get photoGallery {
    if (_photoGallery is EqualUnmodifiableListView) return _photoGallery;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoGallery);
  }

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
  String toString() {
    return 'FoodOrderModel(name: $name, photoGallery: $photoGallery, note: $note, price: $price, quantity: $quantity, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodOrderModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._photoGallery, _photoGallery) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_photoGallery),
      note,
      price,
      quantity,
      totalAmount);

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
          {final String name,
          @JsonKey(name: 'photo_gallery', fromJson: stringToList)
          final List<dynamic> photoGallery,
          final String note,
          final double price,
          final int quantity,
          @JsonKey(name: 'total_amount') final double totalAmount}) =
      _$FoodOrderModelImpl;

  factory _FoodOrderModel.fromJson(Map<String, dynamic> json) =
      _$FoodOrderModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'photo_gallery', fromJson: stringToList)
  List<dynamic> get photoGallery;
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
  @JsonKey(ignore: true)
  _$$FoodOrderModelImplCopyWith<_$FoodOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}