// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BannerModelImpl _$$BannerModelImplFromJson(Map<String, dynamic> json) =>
    _$BannerModelImpl(
      paginationModel: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      bannerItems: (json['data'] as List<dynamic>?)
              ?.map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BannerItem>[],
    );

Map<String, dynamic> _$$BannerModelImplToJson(_$BannerModelImpl instance) =>
    <String, dynamic>{
      'pagination': instance.paginationModel,
      'data': instance.bannerItems,
    };
