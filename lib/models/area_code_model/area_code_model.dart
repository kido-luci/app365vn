import 'package:json_annotation/json_annotation.dart';

part 'area_code_model.g.dart';

@JsonSerializable(explicitToJson: false)
class AreaCodeModel {
  final int id;
  @JsonKey(name: 'ma')
  final String phoneCode;
  @JsonKey(name: 'tenVung')
  final String areaName;
  @JsonKey(name: 'code')
  final String areaCode;
  final String icon;

  AreaCodeModel({
    required this.id,
    required this.phoneCode,
    required this.areaName,
    required this.areaCode,
    required this.icon,
  });

  factory AreaCodeModel.fromJson(Map<String, dynamic> json) =>
      _$AreaCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaCodeModelToJson(this);
}
