// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) {
  return _InfoModel.fromJson(json);
}

/// @nodoc
mixin _$InfoModel {
  @JsonKey(name: 'category_count')
  int get categoryCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_count')
  int get foodCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_count')
  int get tableCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoModelCopyWith<InfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoModelCopyWith<$Res> {
  factory $InfoModelCopyWith(InfoModel value, $Res Function(InfoModel) then) =
      _$InfoModelCopyWithImpl<$Res, InfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'category_count') int categoryCount,
      @JsonKey(name: 'order_count') int orderCount,
      @JsonKey(name: 'food_count') int foodCount,
      @JsonKey(name: 'table_count') int tableCount});
}

/// @nodoc
class _$InfoModelCopyWithImpl<$Res, $Val extends InfoModel>
    implements $InfoModelCopyWith<$Res> {
  _$InfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryCount = null,
    Object? orderCount = null,
    Object? foodCount = null,
    Object? tableCount = null,
  }) {
    return _then(_value.copyWith(
      categoryCount: null == categoryCount
          ? _value.categoryCount
          : categoryCount // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCount: null == foodCount
          ? _value.foodCount
          : foodCount // ignore: cast_nullable_to_non_nullable
              as int,
      tableCount: null == tableCount
          ? _value.tableCount
          : tableCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InfoModelImplCopyWith<$Res>
    implements $InfoModelCopyWith<$Res> {
  factory _$$InfoModelImplCopyWith(
          _$InfoModelImpl value, $Res Function(_$InfoModelImpl) then) =
      __$$InfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'category_count') int categoryCount,
      @JsonKey(name: 'order_count') int orderCount,
      @JsonKey(name: 'food_count') int foodCount,
      @JsonKey(name: 'table_count') int tableCount});
}

/// @nodoc
class __$$InfoModelImplCopyWithImpl<$Res>
    extends _$InfoModelCopyWithImpl<$Res, _$InfoModelImpl>
    implements _$$InfoModelImplCopyWith<$Res> {
  __$$InfoModelImplCopyWithImpl(
      _$InfoModelImpl _value, $Res Function(_$InfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryCount = null,
    Object? orderCount = null,
    Object? foodCount = null,
    Object? tableCount = null,
  }) {
    return _then(_$InfoModelImpl(
      categoryCount: null == categoryCount
          ? _value.categoryCount
          : categoryCount // ignore: cast_nullable_to_non_nullable
              as int,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCount: null == foodCount
          ? _value.foodCount
          : foodCount // ignore: cast_nullable_to_non_nullable
              as int,
      tableCount: null == tableCount
          ? _value.tableCount
          : tableCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InfoModelImpl implements _InfoModel {
  _$InfoModelImpl(
      {@JsonKey(name: 'category_count') this.categoryCount = 0,
      @JsonKey(name: 'order_count') this.orderCount = 0,
      @JsonKey(name: 'food_count') this.foodCount = 0,
      @JsonKey(name: 'table_count') this.tableCount = 0});

  factory _$InfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfoModelImplFromJson(json);

  @override
  @JsonKey(name: 'category_count')
  final int categoryCount;
  @override
  @JsonKey(name: 'order_count')
  final int orderCount;
  @override
  @JsonKey(name: 'food_count')
  final int foodCount;
  @override
  @JsonKey(name: 'table_count')
  final int tableCount;

  @override
  String toString() {
    return 'InfoModel(categoryCount: $categoryCount, orderCount: $orderCount, foodCount: $foodCount, tableCount: $tableCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoModelImpl &&
            (identical(other.categoryCount, categoryCount) ||
                other.categoryCount == categoryCount) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.foodCount, foodCount) ||
                other.foodCount == foodCount) &&
            (identical(other.tableCount, tableCount) ||
                other.tableCount == tableCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, categoryCount, orderCount, foodCount, tableCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoModelImplCopyWith<_$InfoModelImpl> get copyWith =>
      __$$InfoModelImplCopyWithImpl<_$InfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfoModelImplToJson(
      this,
    );
  }
}

abstract class _InfoModel implements InfoModel {
  factory _InfoModel(
      {@JsonKey(name: 'category_count') final int categoryCount,
      @JsonKey(name: 'order_count') final int orderCount,
      @JsonKey(name: 'food_count') final int foodCount,
      @JsonKey(name: 'table_count') final int tableCount}) = _$InfoModelImpl;

  factory _InfoModel.fromJson(Map<String, dynamic> json) =
      _$InfoModelImpl.fromJson;

  @override
  @JsonKey(name: 'category_count')
  int get categoryCount;
  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  @JsonKey(name: 'food_count')
  int get foodCount;
  @override
  @JsonKey(name: 'table_count')
  int get tableCount;
  @override
  @JsonKey(ignore: true)
  _$$InfoModelImplCopyWith<_$InfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
