// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationBean _$StationBeanFromJson(Map<String, dynamic> json) {
  return StationBean(
      name: json['name'] as String,
      no: json['no'] as String,
      lon: json['lon'] as String,
      lat: json['lat'] as String)
    ..stationBus = (json['stationBus'] as List)
        ?.map((e) => e == null
            ? null
            : RealTimeBusBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$StationBeanToJson(StationBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'no': instance.no,
      'lon': instance.lon,
      'lat': instance.lat,
      'stationBus': instance.stationBus
    };
