// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return _PaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PaginationModel {
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_page')
  int get totalPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_item')
  int get totalItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
          PaginationModel value, $Res Function(PaginationModel) then) =
      _$PaginationModelCopyWithImpl<$Res, PaginationModel>;
  @useResult
  $Res call(
      {int page,
      int limit,
      @JsonKey(name: 'total_page') int totalPage,
      @JsonKey(name: 'total_item') int totalItem});
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res, $Val extends PaginationModel>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? totalPage = null,
    Object? totalItem = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPage: null == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalItem: null == totalItem
          ? _value.totalItem
          : totalItem // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationModelImplCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$$PaginationModelImplCopyWith(_$PaginationModelImpl value,
          $Res Function(_$PaginationModelImpl) then) =
      __$$PaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int limit,
      @JsonKey(name: 'total_page') int totalPage,
      @JsonKey(name: 'total_item') int totalItem});
}

/// @nodoc
class __$$PaginationModelImplCopyWithImpl<$Res>
    extends _$PaginationModelCopyWithImpl<$Res, _$PaginationModelImpl>
    implements _$$PaginationModelImplCopyWith<$Res> {
  __$$PaginationModelImplCopyWithImpl(
      _$PaginationModelImpl _value, $Res Function(_$PaginationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? totalPage = null,
    Object? totalItem = null,
  }) {
    return _then(_$PaginationModelImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPage: null == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalItem: null == totalItem
          ? _value.totalItem
          : totalItem // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationModelImpl implements _PaginationModel {
  _$PaginationModelImpl(
      {this.page = 0,
      this.limit = 0,
      @JsonKey(name: 'total_page') this.totalPage = 0,
      @JsonKey(name: 'total_item') this.totalItem = 0});

  factory _$PaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationModelImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey(name: 'total_page')
  final int totalPage;
  @override
  @JsonKey(name: 'total_item')
  final int totalItem;

  @override
  String toString() {
    return 'PaginationModel(page: $page, limit: $limit, totalPage: $totalPage, totalItem: $totalItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationModelImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPage, totalPage) ||
                other.totalPage == totalPage) &&
            (identical(other.totalItem, totalItem) ||
                other.totalItem == totalItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, page, limit, totalPage, totalItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      __$$PaginationModelImplCopyWithImpl<_$PaginationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationModelImplToJson(
      this,
    );
  }
}

abstract class _PaginationModel implements PaginationModel {
  factory _PaginationModel(
          {final int page,
          final int limit,
          @JsonKey(name: 'total_page') final int totalPage,
          @JsonKey(name: 'total_item') final int totalItem}) =
      _$PaginationModelImpl;

  factory _PaginationModel.fromJson(Map<String, dynamic> json) =
      _$PaginationModelImpl.fromJson;

  @override
  int get page;
  @override
  int get limit;
  @override
  @JsonKey(name: 'total_page')
  int get totalPage;
  @override
  @JsonKey(name: 'total_item')
  int get totalItem;
  @override
  @JsonKey(ignore: true)
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
