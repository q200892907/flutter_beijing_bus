import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'get_real_time_bus_req_two_bean.g.dart';

@JsonSerializable()
class GetRealTimeBusReqTwoBean {
  String query;
  String encrypt;
  @JsonKey(name: 'datatype')
  String dataType;

  GetRealTimeBusReqTwoBean({@required this.query, this.encrypt = '1', this.dataType = 'json'});

  factory GetRealTimeBusReqTwoBean.fromJson(Map<String, dynamic> json) => _$GetRealTimeBusReqTwoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GetRealTimeBusReqTwoBeanToJson(this);
}
