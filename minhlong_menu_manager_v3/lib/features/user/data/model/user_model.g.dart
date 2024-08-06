// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      phoneNumber: (json['phone_number'] as num?)?.toInt() ?? 0,
      subPhoneNumber: (json['sub_phone_number'] as num?)?.toInt() ?? 0,
      password: json['password'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      image: json['image'] as String? ?? '',
      expiredAt: json['expired_at'] as String? ?? '',
      extendedAt: json['extended_at'] as String? ?? '',
      role: json['role'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'sub_phone_number': instance.subPhoneNumber,
      'password': instance.password,
      'full_name': instance.fullName,
      'email': instance.email,
      'address': instance.address,
      'image': instance.image,
      'expired_at': instance.expiredAt,
      'extended_at': instance.extendedAt,
      'role': instance.role,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
