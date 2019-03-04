// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_time_bus_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealTimeBusBean _$RealTimeBusBeanFromJson(Map<String, dynamic> json) {
  return RealTimeBusBean(
      gpsUpdateTime: json['gt'] as String,
      mid: json['id'] as String,
      type: json['t'] as String,
      nextStation: json['ns'] as String,
      nextStationNo: json['nsn'] as String,
      nextStationDistince: json['nsd'] as String,
      nextStationRunTimes: json['nsrt'] as String,
      nextStationTime: json['nst'] as String,
      stationDistince: json['sd'] as String,
      stationRunTimes: json['srt'] as String,
      stationNo: json['sn'] as String,
      stationTime: json['st'] as String,
      lon: json['x'] as String,
      lat: json['y'] as String,
      delay: json['lt'] as String,
      serverTime: json['ut'] as String);
}

Map<String, dynamic> _$RealTimeBusBeanToJson(RealTimeBusBean instance) =>
    <String, dynamic>{
      'gt': instance.gpsUpdateTime,
      'id': instance.mid,
      't': instance.type,
      'ns': instance.nextStation,
      'nsn': instance.nextStationNo,
      'nsd': instance.nextStationDistince,
      'nsrt': instance.nextStationRunTimes,
      'nst': instance.nextStationTime,
      'sd': instance.stationDistince,
      'sn': instance.stationNo,
      'srt': instance.stationRunTimes,
      'st': instance.stationTime,
      'x': instance.lon,
      'y': instance.lat,
      'lt': instance.delay,
      'ut': instance.serverTime
    };
