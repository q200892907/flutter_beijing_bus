// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusBean _$BusBeanFromJson(Map<String, dynamic> json) {
  return BusBean(
      lineId: json['lineid'] as String,
      shotName: json['shotname'] as String,
      lineName: json['linename'] as String,
      distince: json['distince'] as String,
      ticket: json['ticket'] as String,
      totalPrice: json['totalPrice'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      coord: json['coord'] as String,
      status: json['status'] as String,
      version: json['version'] as String,
      stations: json['stations'] == null
          ? null
          : StationsBean.fromJson(json['stations'] as Map<String, dynamic>))
    ..lineDirection = json['lineDirection'] as String
    ..startPoint = json['startPoint'] as String
    ..endPoint = json['endPoint'] as String
    ..firstTime = json['firstTime'] as String
    ..endTime = json['endTime'] as String;
}

Map<String, dynamic> _$BusBeanToJson(BusBean instance) => <String, dynamic>{
      'lineid': instance.lineId,
      'shotname': instance.shotName,
      'linename': instance.lineName,
      'distince': instance.distince,
      'ticket': instance.ticket,
      'totalPrice': instance.totalPrice,
      'time': instance.time,
      'type': instance.type,
      'coord': instance.coord,
      'status': instance.status,
      'version': instance.version,
      'stations': instance.stations,
      'lineDirection': instance.lineDirection,
      'startPoint': instance.startPoint,
      'endPoint': instance.endPoint,
      'firstTime': instance.firstTime,
      'endTime': instance.endTime
    };

StationsBean _$StationsBeanFromJson(Map<String, dynamic> json) {
  return StationsBean((json['station'] as List)
      ?.map((e) =>
          e == null ? null : StationBean.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$StationsBeanToJson(StationsBean instance) =>
    <String, dynamic>{'station': instance.station};
