// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaCodeModel _$AreaCodeModelFromJson(Map<String, dynamic> json) =>
    AreaCodeModel(
      id: json['id'] as int,
      phoneCode: json['ma'] as String,
      areaName: json['tenVung'] as String,
      areaCode: json['code'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$AreaCodeModelToJson(AreaCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ma': instance.phoneCode,
      'tenVung': instance.areaName,
      'code': instance.areaCode,
      'icon': instance.icon,
    };
