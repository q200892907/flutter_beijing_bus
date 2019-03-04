import 'package:json_annotation/json_annotation.dart';
import '../include.dart';

part 'station_bean.g.dart';

@JsonSerializable()
class StationBean {
  String name;
  String no;
  String lon;
  String lat;

  List<RealTimeBusBean> stationBus;

  StationBean({
    this.name,
    this.no,
    this.lon,
    this.lat,
  });

  decode(String id) {
    name = ApiUtil.rc4Decode(name, id: id);
    no = ApiUtil.rc4Decode(no, id: id);
    lon = ApiUtil.rc4Decode(lon, id: id);
    lat = ApiUtil.rc4Decode(lat, id: id);
  }

  bool isStation(){
    return no != null && name != null;
  }

  void addBus(RealTimeBusBean bus){
    if(stationBus == null) stationBus = [];
    stationBus.add(bus);
  }

  factory StationBean.fromJson(Map<String, dynamic> json) => _$StationBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StationBeanToJson(this);
}
