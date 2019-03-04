// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_bus_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectBusBean _$CollectBusBeanFromJson(Map<String, dynamic> json) {
  return CollectBusBean(
      id: json['_id'] as int,
      busId: json['busId'] as String,
      busName: json['busName'] as String,
      stationId: json['stationId'] as String,
      stationName: json['stationName'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      home: json['home'] as int);
}

Map<String, dynamic> _$CollectBusBeanToJson(CollectBusBean instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'busId': instance.busId,
      'busName': instance.busName,
      'stationId': instance.stationId,
      'stationName': instance.stationName,
      'start': instance.start,
      'end': instance.end,
      'home': instance.home
    };
