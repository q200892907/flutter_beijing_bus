import '../include.dart';

class AppStringBase extends StringBase {
  String station; //站点
  String direction; //方向
  String line; //线路
  String realTimeQuery; //实时查询
  String changeToTheQuery; //换乘查询
  String query; //查询

  String pleaseSelectLine; //请选择线路
  String pleaseSelectDirection; //请选择方向
  String pleaseSelectStation; //请选择站点

  String normalBus; //1-999路
  String expressBus; //运通线路
  String nightBus; //夜班线路
  String airportBus; //机场线路
  String searchLine; //搜索线路

  String busUnit; //路/线

  String standing; //站
  String fromThe; //距
  String km; //公里
  String arrive; //到达
  String firstBus; //首车
  String endBus; //末车
  String expect; //预计
  String busWillArrive; //车辆即将进站，请准备上车
  String busArrive; //车辆到站，请抓紧时间上车
  String myCollect;//我的收藏

String youNotCollect;//暂无收藏线路呦~
String youNotHome;//暂无展示线路呦~
}
