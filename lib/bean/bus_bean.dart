import 'package:json_annotation/json_annotation.dart';
import '../include.dart';
import 'station_bean.dart';
export 'station_bean.dart';

part 'bus_bean.g.dart';

@JsonSerializable()
class BusBean {
  @JsonKey(name: 'lineid')
  String lineId;
  @JsonKey(name: 'shotname')
  String shotName;
  @JsonKey(name: 'linename')
  String lineName;
  String distince;
  String ticket;
  String totalPrice;
  String time;
  String type;
  String coord;
  String status;
  String version;
  StationsBean stations;

  BusBean({
    this.lineId,
    this.shotName,
    this.lineName,
    this.distince,
    this.ticket,
    this.totalPrice,
    this.time,
    this.type,
    this.coord,
    this.status,
    this.version,
    this.stations,
  });

  String lineDirection;
  String startPoint;
  String endPoint;
  String firstTime;
  String endTime;

  decode() {
    shotName = ApiUtil.rc4Decode(shotName, id: lineId);
    lineName = ApiUtil.rc4Decode(lineName, id: lineId);
    coord = ApiUtil.rc4Decode(coord, id: lineId);
    stations.station.forEach((station) {
      station.decode(lineId);
    });
    firstTime = AppConfigs.TIME_PLACEHOLDER;
    endTime = AppConfigs.TIME_PLACEHOLDER;
    startPoint = AppConfigs.STRING_PLACEHOLDER;
    endPoint = AppConfigs.STRING_PLACEHOLDER;
    lineDirection = AppConfigs.STRING_PLACEHOLDER;

    if (time.contains('-')) {
      List<String> times = time.split('-');
      if (times.length > 1) {
        firstTime = times[0];
        endTime = times[1];
      }
    }
    if (lineName.contains('(') && lineName.contains(')')) {
      lineDirection = lineName.substring(lineName.indexOf('(') + 1, lineName.indexOf(')'));
      if (lineDirection.contains('-')) {
        List<String> points = lineDirection.split('-');
        if (points.length > 1) {
          startPoint = points[0];
          endPoint = points[1];
        }
      }
    }
  }

  factory BusBean.fromJson(Map<String, dynamic> json) => _$BusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BusBeanToJson(this);
}

@JsonSerializable()
class StationsBean {
  List<StationBean> station;

  StationsBean(this.station);

  factory StationsBean.fromJson(Map<String, dynamic> json) => _$StationsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$StationsBeanToJson(this);
}
