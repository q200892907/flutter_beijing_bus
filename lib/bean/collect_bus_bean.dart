import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import '../utils/sqlite_util.dart';
import '../bean/real_time_bus_bean.dart';

part 'collect_bus_bean.g.dart';

enum CollectType {
  NORMAL,
  PROMINENT,
}

@JsonSerializable()
class CollectBusBean {
  @JsonKey(name: CollectProvider.ID)
  int id;
  String busId;
  String busName;
  String stationId;
  String stationName;
  String start;
  String end;
  int home;

  CollectBusBean({
    this.id,
    @required this.busId,
    @required this.busName,
    @required this.stationId,
    @required this.stationName,
    @required this.start,
    @required this.end,
    @required this.home,
  });

  factory CollectBusBean.fromJson(Map<String, dynamic> json) => _$CollectBusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CollectBusBeanToJson(this);
}
