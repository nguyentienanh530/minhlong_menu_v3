// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableModelImpl _$$TableModelImplFromJson(Map<String, dynamic> json) =>
    _$TableModelImpl(
      paginationModel: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      tableItems: (json['data'] as List<dynamic>?)
              ?.map((e) => TableItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TableItem>[],
    );

Map<String, dynamic> _$$TableModelImplToJson(_$TableModelImpl instance) =>
    <String, dynamic>{
      'pagination': instance.paginationModel,
      'data': instance.tableItems,
    };
