// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationModelImpl _$$PaginationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginationModelImpl(
      page: (json['page'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      totalPage: (json['total_page'] as num?)?.toInt() ?? 0,
      totalItem: (json['total_item'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PaginationModelImplToJson(
        _$PaginationModelImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total_page': instance.totalPage,
      'total_item': instance.totalItem,
    };
