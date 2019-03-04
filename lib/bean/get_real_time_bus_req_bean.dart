import 'package:json_annotation/json_annotation.dart';

part 'get_real_time_bus_req_bean.g.dart';

@JsonSerializable()
class GetRealTimeBusReqBean {
  String id;
  String no;

  GetRealTimeBusReqBean({this.id, this.no});

  factory GetRealTimeBusReqBean.fromJson(Map<String, dynamic> json) => _$GetRealTimeBusReqBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GetRealTimeBusReqBeanToJson(this);
}
