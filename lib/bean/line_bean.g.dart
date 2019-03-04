// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineBean _$LineBeanFromJson(Map<String, dynamic> json) {
  return LineBean(
      id: json['id'] as String,
      lineName: json['linename'] as String,
      classify: json['classify'] as String,
      status: json['status'] as String,
      version: json['version'] as String)
    ..lineShortName = json['lineShortName'] as String
    ..lineDirection = json['lineDirection'] as String
    ..startPoint = json['startPoint'] as String
    ..endPoint = json['endPoint'] as String;
}

Map<String, dynamic> _$LineBeanToJson(LineBean instance) => <String, dynamic>{
      'id': instance.id,
      'linename': instance.lineName,
      'classify': instance.classify,
      'status': instance.status,
      'version': instance.version,
      'lineShortName': instance.lineShortName,
      'lineDirection': instance.lineDirection,
      'startPoint': instance.startPoint,
      'endPoint': instance.endPoint
    };
