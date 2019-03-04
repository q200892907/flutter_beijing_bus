// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_real_time_bus_req_two_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRealTimeBusReqTwoBean _$GetRealTimeBusReqTwoBeanFromJson(
    Map<String, dynamic> json) {
  return GetRealTimeBusReqTwoBean(
      query: json['query'] as String,
      encrypt: json['encrypt'] as String,
      dataType: json['datatype'] as String);
}

Map<String, dynamic> _$GetRealTimeBusReqTwoBeanToJson(
        GetRealTimeBusReqTwoBean instance) =>
    <String, dynamic>{
      'query': instance.query,
      'encrypt': instance.encrypt,
      'datatype': instance.dataType
    };
