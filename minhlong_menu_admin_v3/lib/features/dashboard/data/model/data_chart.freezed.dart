// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_chart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DataChart _$DataChartFromJson(Map<String, dynamic> json) {
  return _DataChart.fromJson(json);
}

/// @nodoc
mixin _$DataChart {
  @JsonKey(name: 'total_price')
  dynamic get totalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataChartCopyWith<DataChart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataChartCopyWith<$Res> {
  factory $DataChartCopyWith(DataChart value, $Res Function(DataChart) then) =
      _$DataChartCopyWithImpl<$Res, DataChart>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_price') dynamic totalPrice,
      @JsonKey(name: 'date') String date});
}

/// @nodoc
class _$DataChartCopyWithImpl<$Res, $Val extends DataChart>
    implements $DataChartCopyWith<$Res> {
  _$DataChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrice = freezed,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataChartImplCopyWith<$Res>
    implements $DataChartCopyWith<$Res> {
  factory _$$DataChartImplCopyWith(
          _$DataChartImpl value, $Res Function(_$DataChartImpl) then) =
      __$$DataChartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_price') dynamic totalPrice,
      @JsonKey(name: 'date') String date});
}

/// @nodoc
class __$$DataChartImplCopyWithImpl<$Res>
    extends _$DataChartCopyWithImpl<$Res, _$DataChartImpl>
    implements _$$DataChartImplCopyWith<$Res> {
  __$$DataChartImplCopyWithImpl(
      _$DataChartImpl _value, $Res Function(_$DataChartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrice = freezed,
    Object? date = null,
  }) {
    return _then(_$DataChartImpl(
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataChartImpl implements _DataChart {
  _$DataChartImpl(
      {@JsonKey(name: 'total_price') this.totalPrice = 0,
      @JsonKey(name: 'date') this.date = ''});

  factory _$DataChartImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataChartImplFromJson(json);

  @override
  @JsonKey(name: 'total_price')
  final dynamic totalPrice;
  @override
  @JsonKey(name: 'date')
  final String date;

  @override
  String toString() {
    return 'DataChart(totalPrice: $totalPrice, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataChartImpl &&
            const DeepCollectionEquality()
                .equals(other.totalPrice, totalPrice) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(totalPrice), date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataChartImplCopyWith<_$DataChartImpl> get copyWith =>
      __$$DataChartImplCopyWithImpl<_$DataChartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataChartImplToJson(
      this,
    );
  }
}

abstract class _DataChart implements DataChart {
  factory _DataChart(
      {@JsonKey(name: 'total_price') final dynamic totalPrice,
      @JsonKey(name: 'date') final String date}) = _$DataChartImpl;

  factory _DataChart.fromJson(Map<String, dynamic> json) =
      _$DataChartImpl.fromJson;

  @override
  @JsonKey(name: 'total_price')
  dynamic get totalPrice;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$DataChartImplCopyWith<_$DataChartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
