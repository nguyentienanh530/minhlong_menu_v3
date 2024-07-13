// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return _BannerModel.fromJson(json);
}

/// @nodoc
mixin _$BannerModel {
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<BannerItem> get bannerItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BannerModelCopyWith<BannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerModelCopyWith<$Res> {
  factory $BannerModelCopyWith(
          BannerModel value, $Res Function(BannerModel) then) =
      _$BannerModelCopyWithImpl<$Res, BannerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<BannerItem> bannerItems});

  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class _$BannerModelCopyWithImpl<$Res, $Val extends BannerModel>
    implements $BannerModelCopyWith<$Res> {
  _$BannerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? bannerItems = null,
  }) {
    return _then(_value.copyWith(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      bannerItems: null == bannerItems
          ? _value.bannerItems
          : bannerItems // ignore: cast_nullable_to_non_nullable
              as List<BannerItem>,
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
abstract class _$$BannerModelImplCopyWith<$Res>
    implements $BannerModelCopyWith<$Res> {
  factory _$$BannerModelImplCopyWith(
          _$BannerModelImpl value, $Res Function(_$BannerModelImpl) then) =
      __$$BannerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<BannerItem> bannerItems});

  @override
  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class __$$BannerModelImplCopyWithImpl<$Res>
    extends _$BannerModelCopyWithImpl<$Res, _$BannerModelImpl>
    implements _$$BannerModelImplCopyWith<$Res> {
  __$$BannerModelImplCopyWithImpl(
      _$BannerModelImpl _value, $Res Function(_$BannerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? bannerItems = null,
  }) {
    return _then(_$BannerModelImpl(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      bannerItems: null == bannerItems
          ? _value._bannerItems
          : bannerItems // ignore: cast_nullable_to_non_nullable
              as List<BannerItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BannerModelImpl implements _BannerModel {
  _$BannerModelImpl(
      {@JsonKey(name: 'pagination') this.paginationModel,
      @JsonKey(name: 'data')
      final List<BannerItem> bannerItems = const <BannerItem>[]})
      : _bannerItems = bannerItems;

  factory _$BannerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerModelImplFromJson(json);

  @override
  @JsonKey(name: 'pagination')
  final PaginationModel? paginationModel;
  final List<BannerItem> _bannerItems;
  @override
  @JsonKey(name: 'data')
  List<BannerItem> get bannerItems {
    if (_bannerItems is EqualUnmodifiableListView) return _bannerItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bannerItems);
  }

  @override
  String toString() {
    return 'BannerModel(paginationModel: $paginationModel, bannerItems: $bannerItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerModelImpl &&
            (identical(other.paginationModel, paginationModel) ||
                other.paginationModel == paginationModel) &&
            const DeepCollectionEquality()
                .equals(other._bannerItems, _bannerItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paginationModel,
      const DeepCollectionEquality().hash(_bannerItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerModelImplCopyWith<_$BannerModelImpl> get copyWith =>
      __$$BannerModelImplCopyWithImpl<_$BannerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerModelImplToJson(
      this,
    );
  }
}

abstract class _BannerModel implements BannerModel {
  factory _BannerModel(
          {@JsonKey(name: 'pagination') final PaginationModel? paginationModel,
          @JsonKey(name: 'data') final List<BannerItem> bannerItems}) =
      _$BannerModelImpl;

  factory _BannerModel.fromJson(Map<String, dynamic> json) =
      _$BannerModelImpl.fromJson;

  @override
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel;
  @override
  @JsonKey(name: 'data')
  List<BannerItem> get bannerItems;
  @override
  @JsonKey(ignore: true)
  _$$BannerModelImplCopyWith<_$BannerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
