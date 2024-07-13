// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerItemImpl _$$BannerItemImplFromJson(Map<String, dynamic> json) =>
    _$BannerItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      image: json['image'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$$BannerItemImplToJson(_$BannerItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
