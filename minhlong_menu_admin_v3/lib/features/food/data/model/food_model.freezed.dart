// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return _FoodModel.fromJson(json);
}

/// @nodoc
mixin _$FoodModel {
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<FoodItem> get orderItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res, FoodModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<FoodItem> orderItems});

  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class _$FoodModelCopyWithImpl<$Res, $Val extends FoodModel>
    implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? orderItems = null,
  }) {
    return _then(_value.copyWith(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      orderItems: null == orderItems
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res>? get paginationModel {
    if (_value.paginationModel == null) {
      return null;
    }

    return $PaginationModelCopyWith<$Res>(_value.paginationModel!, (value) {
      return _then(_value.copyWith(paginationModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodModelImplCopyWith<$Res>
    implements $FoodModelCopyWith<$Res> {
  factory _$$FoodModelImplCopyWith(
          _$FoodModelImpl value, $Res Function(_$FoodModelImpl) then) =
      __$$FoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<FoodItem> orderItems});

  @override
  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class __$$FoodModelImplCopyWithImpl<$Res>
    extends _$FoodModelCopyWithImpl<$Res, _$FoodModelImpl>
    implements _$$FoodModelImplCopyWith<$Res> {
  __$$FoodModelImplCopyWithImpl(
      _$FoodModelImpl _value, $Res Function(_$FoodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? orderItems = null,
  }) {
    return _then(_$FoodModelImpl(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      orderItems: null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodModelImpl implements _FoodModel {
  _$FoodModelImpl(
      {@JsonKey(name: 'pagination') this.paginationModel,
      @JsonKey(name: 'data')
      final List<FoodItem> orderItems = const <FoodItem>[]})
      : _orderItems = orderItems;

  factory _$FoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodModelImplFromJson(json);

  @override
  @JsonKey(name: 'pagination')
  final PaginationModel? paginationModel;
  final List<FoodItem> _orderItems;
  @override
  @JsonKey(name: 'data')
  List<FoodItem> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  String toString() {
    return 'FoodModel(paginationModel: $paginationModel, orderItems: $orderItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodModelImpl &&
            (identical(other.paginationModel, paginationModel) ||
                other.paginationModel == paginationModel) &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paginationModel,
      const DeepCollectionEquality().hash(_orderItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      __$$FoodModelImplCopyWithImpl<_$FoodModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodModelImplToJson(
      this,
    );
  }
}

abstract class _FoodModel implements FoodModel {
  factory _FoodModel(
          {@JsonKey(name: 'pagination') final PaginationModel? paginationModel,
          @JsonKey(name: 'data') final List<FoodItem> orderItems}) =
      _$FoodModelImpl;

  factory _FoodModel.fromJson(Map<String, dynamic> json) =
      _$FoodModelImpl.fromJson;

  @override
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel;
  @override
  @JsonKey(name: 'data')
  List<FoodItem> get orderItems;
  @override
  @JsonKey(ignore: true)
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
