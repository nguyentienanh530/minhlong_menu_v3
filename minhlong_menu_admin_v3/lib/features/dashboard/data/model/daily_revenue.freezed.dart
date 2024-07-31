// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_revenue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyRevenue _$DailyRevenueFromJson(Map<String, dynamic> json) {
  return _DailyRevenue.fromJson(json);
}

/// @nodoc
mixin _$DailyRevenue {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price')
  double get revenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyRevenueCopyWith<DailyRevenue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRevenueCopyWith<$Res> {
  factory $DailyRevenueCopyWith(
          DailyRevenue value, $Res Function(DailyRevenue) then) =
      _$DailyRevenueCopyWithImpl<$Res, DailyRevenue>;
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'total_price') double revenue,
      @JsonKey(name: 'order_count') int orderCount});
}

/// @nodoc
class _$DailyRevenueCopyWithImpl<$Res, $Val extends DailyRevenue>
    implements $DailyRevenueCopyWith<$Res> {
  _$DailyRevenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? revenue = null,
    Object? orderCount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyRevenueImplCopyWith<$Res>
    implements $DailyRevenueCopyWith<$Res> {
  factory _$$DailyRevenueImplCopyWith(
          _$DailyRevenueImpl value, $Res Function(_$DailyRevenueImpl) then) =
      __$$DailyRevenueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'total_price') double revenue,
      @JsonKey(name: 'order_count') int orderCount});
}

/// @nodoc
class __$$DailyRevenueImplCopyWithImpl<$Res>
    extends _$DailyRevenueCopyWithImpl<$Res, _$DailyRevenueImpl>
    implements _$$DailyRevenueImplCopyWith<$Res> {
  __$$DailyRevenueImplCopyWithImpl(
      _$DailyRevenueImpl _value, $Res Function(_$DailyRevenueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? revenue = null,
    Object? orderCount = null,
  }) {
    return _then(_$DailyRevenueImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      orderCount: null == orderCount
          ? _value.orderCount
          : orderCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyRevenueImpl implements _DailyRevenue {
  const _$DailyRevenueImpl(
      {this.date = '',
      @JsonKey(name: 'total_price') this.revenue = 0.0,
      @JsonKey(name: 'order_count') this.orderCount = 0});

  factory _$DailyRevenueImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRevenueImplFromJson(json);

  @override
  @JsonKey()
  final String date;
  @override
  @JsonKey(name: 'total_price')
  final double revenue;
  @override
  @JsonKey(name: 'order_count')
  final int orderCount;

  @override
  String toString() {
    return 'DailyRevenue(date: $date, revenue: $revenue, orderCount: $orderCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRevenueImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, revenue, orderCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRevenueImplCopyWith<_$DailyRevenueImpl> get copyWith =>
      __$$DailyRevenueImplCopyWithImpl<_$DailyRevenueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRevenueImplToJson(
      this,
    );
  }
}

abstract class _DailyRevenue implements DailyRevenue {
  const factory _DailyRevenue(
      {final String date,
      @JsonKey(name: 'total_price') final double revenue,
      @JsonKey(name: 'order_count') final int orderCount}) = _$DailyRevenueImpl;

  factory _DailyRevenue.fromJson(Map<String, dynamic> json) =
      _$DailyRevenueImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total_price')
  double get revenue;
  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  @JsonKey(ignore: true)
  _$$DailyRevenueImplCopyWith<_$DailyRevenueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
