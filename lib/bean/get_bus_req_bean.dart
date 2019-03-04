import 'package:json_annotation/json_annotation.dart';

part 'get_bus_req_bean.g.dart';

@JsonSerializable()
class GetBusReqBean{
  String id;

  GetBusReqBean({this.id});

  factory GetBusReqBean.fromJson(Map<String, dynamic> json) => _$GetBusReqBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GetBusReqBeanToJson(this);
}