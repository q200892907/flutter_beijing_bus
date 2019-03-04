import 'package:json_annotation/json_annotation.dart';
import '../include.dart';

part 'real_time_bus_bean.g.dart';

enum BusStatus {
  RUNNING,
  WILL_ARRIVE, //即将进站
  ARRIVE, //进站
}

@JsonSerializable()
class RealTimeBusBean {
  @JsonKey(name: 'gt')
  String gpsUpdateTime; //gps更新时间
  @JsonKey(name: 'id')
  String mid; //公交编号
  @JsonKey(name: 't')
  String type; //未知
  @JsonKey(name: 'ns')
  String nextStation; //下一站名称
  @JsonKey(name: 'nsn')
  String nextStationNo; //下一站编号
  @JsonKey(name: 'nsd')
  String nextStationDistince; //下一站距离
  @JsonKey(name: 'nsrt')
  String nextStationRunTimes; //下一站时间
  @JsonKey(name: 'nst')
  String nextStationTime; //预计到达时间
  @JsonKey(name: 'sd')
  String stationDistince; //距离当前站距离
  @JsonKey(name: 'sn')
  String stationNo; //站号
  @JsonKey(name: 'srt')
  String stationRunTimes; //距离当前站时间秒
  @JsonKey(name: 'st')
  String stationTime; //预计到达当前站时间
  @JsonKey(name: 'x')
  String lon;
  @JsonKey(name: 'y')
  String lat;
  @JsonKey(name: 'lt')
  String delay; //红绿灯延误时间
  @JsonKey(name: 'ut')
  String serverTime;

  RealTimeBusBean({
    this.gpsUpdateTime,
    this.mid,
    this.type,
    this.nextStation,
    this.nextStationNo,
    this.nextStationDistince,
    this.nextStationRunTimes,
    this.nextStationTime,
    this.stationDistince,
    this.stationRunTimes,
    this.stationNo,
    this.stationTime,
    this.lon,
    this.lat,
    this.delay,
    this.serverTime,
  });

  bool isEmpty(){
    return mid == null || mid.isEmpty;
  }

  decode() {
    nextStation = ApiUtil.rc4Decode(nextStation, id: gpsUpdateTime);
    nextStationNo = ApiUtil.rc4Decode(nextStationNo, id: gpsUpdateTime);
    nextStationDistince = (int.parse(nextStationDistince) / 1000).toStringAsFixed(2);
    nextStationTime = DateUtil.long2String(millisecond: int.parse(nextStationTime) * 1000, format: "HH:ss");
    stationDistince = (int.parse(ApiUtil.rc4Decode(stationDistince, id: gpsUpdateTime)) / 1000).toStringAsFixed(2);
    stationRunTimes = ApiUtil.rc4Decode(stationRunTimes, id: gpsUpdateTime);
    stationTime = DateUtil.long2String(millisecond: int.parse(ApiUtil.rc4Decode(stationTime, id: gpsUpdateTime)) * 1000, format: "HH:mm");
    lat = ApiUtil.rc4Decode(lat, id: gpsUpdateTime);
    lon = ApiUtil.rc4Decode(lon, id: gpsUpdateTime);
  }

  //基于搜索站点进行车辆行驶状态判断
  BusStatus busStatus(String stationId) {
    if (_isArrived(stationId)) return BusStatus.ARRIVE;
    if (_isWillArrive(stationId)) return BusStatus.WILL_ARRIVE;
    return BusStatus.RUNNING;
  }

  int arrivedStationNum(String stationId){
    return int.parse(stationId) - int.parse(nextStationNo) + 1;
  }

  //基于下一站的状态
  BusStatus busStatusForNextStation() {
    if (_isPausedForNextStation()) return BusStatus.ARRIVE;
    if (_isWillArriveForNextStation()) return BusStatus.WILL_ARRIVE;
    return BusStatus.RUNNING;
  }

  //是否在运行
  bool _isRunning() {
    return "-1" != stationRunTimes;
  }

  //即将进入搜索站点
  bool _isWillArrive(String stationId) {
    return stationId == nextStationNo && double.parse(nextStationDistince) < 0.5;
  }

  //已到达搜索站点
  bool _isArrived(String stationId) {
    return stationId == nextStationNo && (!_isRunning());
  }

  //是否停止在下一站点
  bool _isPausedForNextStation() {
    return !_isRunningForNextStation();
  }

  //是否正在往下一站点运行
  bool _isRunningForNextStation() {
    return '-1' != nextStationRunTimes;
  }

  //是否即将进入下一站点
  bool _isWillArriveForNextStation() {
    return double.parse(nextStationDistince) < 0.5;
  }

  factory RealTimeBusBean.fromJson(Map<String, dynamic> json) => _$RealTimeBusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RealTimeBusBeanToJson(this);
}
