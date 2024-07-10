// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TableModel _$TableModelFromJson(Map<String, dynamic> json) {
  return _TableModel.fromJson(json);
}

/// @nodoc
mixin _$TableModel {
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<TableItem> get tableItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TableModelCopyWith<TableModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableModelCopyWith<$Res> {
  factory $TableModelCopyWith(
          TableModel value, $Res Function(TableModel) then) =
      _$TableModelCopyWithImpl<$Res, TableModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<TableItem> tableItems});

  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class _$TableModelCopyWithImpl<$Res, $Val extends TableModel>
    implements $TableModelCopyWith<$Res> {
  _$TableModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? tableItems = null,
  }) {
    return _then(_value.copyWith(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      tableItems: null == tableItems
          ? _value.tableItems
          : tableItems // ignore: cast_nullable_to_non_nullable
              as List<TableItem>,
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
abstract class _$$TableModelImplCopyWith<$Res>
    implements $TableModelCopyWith<$Res> {
  factory _$$TableModelImplCopyWith(
          _$TableModelImpl value, $Res Function(_$TableModelImpl) then) =
      __$$TableModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @JsonKey(name: 'data') List<TableItem> tableItems});

  @override
  $PaginationModelCopyWith<$Res>? get paginationModel;
}

/// @nodoc
class __$$TableModelImplCopyWithImpl<$Res>
    extends _$TableModelCopyWithImpl<$Res, _$TableModelImpl>
    implements _$$TableModelImplCopyWith<$Res> {
  __$$TableModelImplCopyWithImpl(
      _$TableModelImpl _value, $Res Function(_$TableModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paginationModel = freezed,
    Object? tableItems = null,
  }) {
    return _then(_$TableModelImpl(
      paginationModel: freezed == paginationModel
          ? _value.paginationModel
          : paginationModel // ignore: cast_nullable_to_non_nullable
              as PaginationModel?,
      tableItems: null == tableItems
          ? _value._tableItems
          : tableItems // ignore: cast_nullable_to_non_nullable
              as List<TableItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TableModelImpl implements _TableModel {
  _$TableModelImpl(
      {@JsonKey(name: 'pagination') this.paginationModel,
      @JsonKey(name: 'data')
      final List<TableItem> tableItems = const <TableItem>[]})
      : _tableItems = tableItems;

  factory _$TableModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableModelImplFromJson(json);

  @override
  @JsonKey(name: 'pagination')
  final PaginationModel? paginationModel;
  final List<TableItem> _tableItems;
  @override
  @JsonKey(name: 'data')
  List<TableItem> get tableItems {
    if (_tableItems is EqualUnmodifiableListView) return _tableItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableItems);
  }

  @override
  String toString() {
    return 'TableModel(paginationModel: $paginationModel, tableItems: $tableItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableModelImpl &&
            (identical(other.paginationModel, paginationModel) ||
                other.paginationModel == paginationModel) &&
            const DeepCollectionEquality()
                .equals(other._tableItems, _tableItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paginationModel,
      const DeepCollectionEquality().hash(_tableItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TableModelImplCopyWith<_$TableModelImpl> get copyWith =>
      __$$TableModelImplCopyWithImpl<_$TableModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableModelImplToJson(
      this,
    );
  }
}

abstract class _TableModel implements TableModel {
  factory _TableModel(
          {@JsonKey(name: 'pagination') final PaginationModel? paginationModel,
          @JsonKey(name: 'data') final List<TableItem> tableItems}) =
      _$TableModelImpl;

  factory _TableModel.fromJson(Map<String, dynamic> json) =
      _$TableModelImpl.fromJson;

  @override
  @JsonKey(name: 'pagination')
  PaginationModel? get paginationModel;
  @override
  @JsonKey(name: 'data')
  List<TableItem> get tableItems;
  @override
  @JsonKey(ignore: true)
  _$$TableModelImplCopyWith<_$TableModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
