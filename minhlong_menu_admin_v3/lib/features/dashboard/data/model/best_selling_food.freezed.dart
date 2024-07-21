// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'best_selling_food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BestSellingFood _$BestSellingFoodFromJson(Map<String, dynamic> json) {
  return _BestSellingFood.fromJson(json);
}

/// @nodoc
mixin _$BestSellingFood {
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BestSellingFoodCopyWith<BestSellingFood> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BestSellingFoodCopyWith<$Res> {
  factory $BestSellingFoodCopyWith(
          BestSellingFood value, $Res Function(BestSellingFood) then) =
      _$BestSellingFoodCopyWithImpl<$Res, BestSellingFood>;
  @useResult
  $Res call(
      {@JsonKey(name: 'order_count') int orderCount,
      @JsonKey(name: 'name') String name});
}

/// @nodoc
class _$BestSellingFoodCopyWithImpl<$Res, $Val extends BestSellingFood>
    implements $BestSellingFoodCopyWith<$Res> {
  _$BestSellingFoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCount = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BestSellingFoodImplCopyWith<$Res>
    implements $BestSellingFoodCopyWith<$Res> {
  factory _$$BestSellingFoodImplCopyWith(_$BestSellingFoodImpl value,
          $Res Function(_$BestSellingFoodImpl) then) =
      __$$BestSellingFoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'order_count') int orderCount,
      @JsonKey(name: 'name') String name});
}

/// @nodoc
class __$$BestSellingFoodImplCopyWithImpl<$Res>
    extends _$BestSellingFoodCopyWithImpl<$Res, _$BestSellingFoodImpl>
    implements _$$BestSellingFoodImplCopyWith<$Res> {
  __$$BestSellingFoodImplCopyWithImpl(
      _$BestSellingFoodImpl _value, $Res Function(_$BestSellingFoodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCount = null,
    Object? name = null,
  }) {
    return _then(_$BestSellingFoodImpl(
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BestSellingFoodImpl implements _BestSellingFood {
  _$BestSellingFoodImpl(
      {@JsonKey(name: 'order_count') this.orderCount = 0,
      @JsonKey(name: 'name') this.name = ''});

  factory _$BestSellingFoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$BestSellingFoodImplFromJson(json);

  @override
  @JsonKey(name: 'order_count')
  final int orderCount;
  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  String toString() {
    return 'BestSellingFood(orderCount: $orderCount, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BestSellingFoodImpl &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderCount, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BestSellingFoodImplCopyWith<_$BestSellingFoodImpl> get copyWith =>
      __$$BestSellingFoodImplCopyWithImpl<_$BestSellingFoodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BestSellingFoodImplToJson(
      this,
    );
  }
}

abstract class _BestSellingFood implements BestSellingFood {
  factory _BestSellingFood(
      {@JsonKey(name: 'order_count') final int orderCount,
      @JsonKey(name: 'name') final String name}) = _$BestSellingFoodImpl;

  factory _BestSellingFood.fromJson(Map<String, dynamic> json) =
      _$BestSellingFoodImpl.fromJson;

  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$BestSellingFoodImplCopyWith<_$BestSellingFoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
