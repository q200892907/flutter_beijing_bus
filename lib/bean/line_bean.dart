import 'package:json_annotation/json_annotation.dart';
import '../include.dart';

part 'line_bean.g.dart';

@JsonSerializable()
class LineBean {
  String id;
  @JsonKey(name: 'linename')
  String lineName;
  String classify;
  String status;
  String version;

  LineBean({this.id, this.lineName, this.classify, this.status, this.version});

  String lineShortName;
  String lineDirection;
  String startPoint;
  String endPoint;

  void init() {
    if (lineName.contains('(') && lineName.contains(')')) {
      lineShortName = lineName.substring(0, lineName.indexOf('('));
      lineDirection = lineName.substring(lineName.indexOf('(') + 1, lineName.indexOf(')'));
      if(lineDirection.contains('-')){
        List<String> points= lineDirection.split('-');
        if(points.length > 1){
          startPoint = points[0];
          endPoint = points[1];
        }else{
          startPoint = '???';
          endPoint = '???';
        }
      }else{
        startPoint = '???';
        endPoint = '???';
      }
    } else {
      lineShortName = '???';
      lineDirection = '???';
      startPoint = '???';
      endPoint = '???';
    }
  }

  bool isOperating(){
    return status == '0';
  }

  bool query(String queryStr) {
    return lineShortName.contains(queryStr);
  }

  BusType busType(BuildContext context) {
    if (classify == AppStrings.getLocale(context).normalBus) {
      return BusType.NORMAL;
    } else if (classify == AppStrings.getLocale(context).nightBus) {
      return BusType.NIGHT;
    } else if (classify == AppStrings.getLocale(context).expressBus) {
      return BusType.EXPRESS;
    } else {
      return BusType.AIRPORT;
    }
  }

  factory LineBean.fromJson(Map<String, dynamic> json) => _$LineBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LineBeanToJson(this);
}
