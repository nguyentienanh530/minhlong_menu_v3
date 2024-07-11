// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      paginationModel: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      categoryItems: (json['data'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CategoryItem>[],
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'pagination': instance.paginationModel,
      'data': instance.categoryItems,
    };
