import 'app_string_base.dart';
import '../include.dart';

class AppStringZh extends AppStringBase with StringZh {
  @override
  String get appName => '北京实时公交';

  @override
  String get station => '站点';

  @override
  String get direction => '方向';

  @override
  String get line => '线路';

  @override
  String get realTimeQuery => '实时查询';

  @override
  String get changeToTheQuery => '换乘查询';

  @override
  String get query => '查询';

  @override
  String get pleaseSelectLine => '请选择线路';

  @override
  String get pleaseSelectDirection => '请选择方向';

  @override
  String get pleaseSelectStation => '请选择站点';

  @override
  String get normalBus => '1-999路';

  @override
  String get expressBus => '运通线路';

  @override
  String get nightBus => '夜班线路';

  @override
  String get airportBus => '机场线路';

  @override
  String get searchLine => '搜索线路';

  @override
  String get busUnit => '路(线)';

  @override
  String get standing => '站';

  @override
  String get fromThe => '距';

  @override
  String get km => '公里';

  @override
  String get arrive => '到达';

  @override
  String get firstBus => '首车';

  @override
  String get endBus => '末车';

  @override
  String get expect => '预计';

  @override
  String get busWillArrive => '车辆即将进站，请准备上车';

  @override
  String get busArrive => '车辆到站，请抓紧时间上车';

  @override
  String get myCollect => '我的收藏';

  @override
  String get youNotCollect => '\n暂无收藏线路呦~';

  @override
  String get youNotHome => '\n暂无展示线路呦~';
}
