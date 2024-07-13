// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_food_size_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ItemFoodSizeDTO {
  double? get height => throw _privateConstructorUsedError;
  double? get width => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemFoodSizeDTOCopyWith<ItemFoodSizeDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemFoodSizeDTOCopyWith<$Res> {
  factory $ItemFoodSizeDTOCopyWith(
          ItemFoodSizeDTO value, $Res Function(ItemFoodSizeDTO) then) =
      _$ItemFoodSizeDTOCopyWithImpl<$Res, ItemFoodSizeDTO>;
  @useResult
  $Res call({double? height, double? width});
}

/// @nodoc
class _$ItemFoodSizeDTOCopyWithImpl<$Res, $Val extends ItemFoodSizeDTO>
    implements $ItemFoodSizeDTOCopyWith<$Res> {
  _$ItemFoodSizeDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = freezed,
    Object? width = freezed,
  }) {
    return _then(_value.copyWith(
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemFoodSizeDTOImplCopyWith<$Res>
    implements $ItemFoodSizeDTOCopyWith<$Res> {
  factory _$$ItemFoodSizeDTOImplCopyWith(_$ItemFoodSizeDTOImpl value,
          $Res Function(_$ItemFoodSizeDTOImpl) then) =
      __$$ItemFoodSizeDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? height, double? width});
}

/// @nodoc
class __$$ItemFoodSizeDTOImplCopyWithImpl<$Res>
    extends _$ItemFoodSizeDTOCopyWithImpl<$Res, _$ItemFoodSizeDTOImpl>
    implements _$$ItemFoodSizeDTOImplCopyWith<$Res> {
  __$$ItemFoodSizeDTOImplCopyWithImpl(
      _$ItemFoodSizeDTOImpl _value, $Res Function(_$ItemFoodSizeDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = freezed,
    Object? width = freezed,
  }) {
    return _then(_$ItemFoodSizeDTOImpl(
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ItemFoodSizeDTOImpl implements _ItemFoodSizeDTO {
  _$ItemFoodSizeDTOImpl({this.height, this.width});

  @override
  final double? height;
  @override
  final double? width;

  @override
  String toString() {
    return 'ItemFoodSizeDTO(height: $height, width: $width)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemFoodSizeDTOImpl &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.width, width) || other.width == width));
  }

  @override
  int get hashCode => Object.hash(runtimeType, height, width);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemFoodSizeDTOImplCopyWith<_$ItemFoodSizeDTOImpl> get copyWith =>
      __$$ItemFoodSizeDTOImplCopyWithImpl<_$ItemFoodSizeDTOImpl>(
          this, _$identity);
}

abstract class _ItemFoodSizeDTO implements ItemFoodSizeDTO {
  factory _ItemFoodSizeDTO({final double? height, final double? width}) =
      _$ItemFoodSizeDTOImpl;

  @override
  double? get height;
  @override
  double? get width;
  @override
  @JsonKey(ignore: true)
  _$$ItemFoodSizeDTOImplCopyWith<_$ItemFoodSizeDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
