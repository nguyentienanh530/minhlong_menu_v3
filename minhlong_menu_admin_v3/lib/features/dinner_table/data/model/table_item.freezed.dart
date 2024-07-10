// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TableItem _$TableItemFromJson(Map<String, dynamic> json) {
  return _TableItem.fromJson(json);
}

/// @nodoc
mixin _$TableItem {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get seats => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_use')
  bool? get isUse => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int? get orderCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TableItemCopyWith<TableItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableItemCopyWith<$Res> {
  factory $TableItemCopyWith(TableItem value, $Res Function(TableItem) then) =
      _$TableItemCopyWithImpl<$Res, TableItem>;
  @useResult
  $Res call(
      {int id,
      String name,
      int seats,
      @JsonKey(name: 'is_use') bool? isUse,
      @JsonKey(name: 'order_count') int? orderCount});
}

/// @nodoc
class _$TableItemCopyWithImpl<$Res, $Val extends TableItem>
    implements $TableItemCopyWith<$Res> {
  _$TableItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? seats = null,
    Object? isUse = freezed,
    Object? orderCount = freezed,
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
      seats: null == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as int,
      isUse: freezed == isUse
          ? _value.isUse
          : isUse // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderCount: freezed == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableItemImplCopyWith<$Res>
    implements $TableItemCopyWith<$Res> {
  factory _$$TableItemImplCopyWith(
          _$TableItemImpl value, $Res Function(_$TableItemImpl) then) =
      __$$TableItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      int seats,
      @JsonKey(name: 'is_use') bool? isUse,
      @JsonKey(name: 'order_count') int? orderCount});
}

/// @nodoc
class __$$TableItemImplCopyWithImpl<$Res>
    extends _$TableItemCopyWithImpl<$Res, _$TableItemImpl>
    implements _$$TableItemImplCopyWith<$Res> {
  __$$TableItemImplCopyWithImpl(
      _$TableItemImpl _value, $Res Function(_$TableItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? seats = null,
    Object? isUse = freezed,
    Object? orderCount = freezed,
  }) {
    return _then(_$TableItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      seats: null == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as int,
      isUse: freezed == isUse
          ? _value.isUse
          : isUse // ignore: cast_nullable_to_non_nullable
              as bool?,
      orderCount: freezed == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableItemImpl implements _TableItem {
  _$TableItemImpl(
      {this.id = 0,
      this.name = '',
      this.seats = 0,
      @JsonKey(name: 'is_use') this.isUse = false,
      @JsonKey(name: 'order_count') this.orderCount = 0});

  factory _$TableItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableItemImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int seats;
  @override
  @JsonKey(name: 'is_use')
  final bool? isUse;
  @override
  @JsonKey(name: 'order_count')
  final int? orderCount;

  @override
  String toString() {
    return 'TableItem(id: $id, name: $name, seats: $seats, isUse: $isUse, orderCount: $orderCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.seats, seats) || other.seats == seats) &&
            (identical(other.isUse, isUse) || other.isUse == isUse) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, seats, isUse, orderCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TableItemImplCopyWith<_$TableItemImpl> get copyWith =>
      __$$TableItemImplCopyWithImpl<_$TableItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableItemImplToJson(
      this,
    );
  }
}

abstract class _TableItem implements TableItem {
  factory _TableItem(
      {final int id,
      final String name,
      final int seats,
      @JsonKey(name: 'is_use') final bool? isUse,
      @JsonKey(name: 'order_count') final int? orderCount}) = _$TableItemImpl;

  factory _TableItem.fromJson(Map<String, dynamic> json) =
      _$TableItemImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get seats;
  @override
  @JsonKey(name: 'is_use')
  bool? get isUse;
  @override
  @JsonKey(name: 'order_count')
  int? get orderCount;
  @override
  @JsonKey(ignore: true)
  _$$TableItemImplCopyWith<_$TableItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
