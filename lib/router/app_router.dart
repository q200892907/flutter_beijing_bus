import '../include.dart';

import '../page/splash_page.dart';
import '../page/main_page.dart';
import '../page/bus_page.dart';
import '../page/collect_page.dart';

//路由参数配置
class RouteParams {
  static const String BUS_ID = 'BUS_ID';
  static const String BUS_NAME = 'BUS_NAME';
  static const String STATION_ID = 'STATION_ID';
  static const String STATION_NAME = 'STATION_NAME';
}

//APP路由相关设置
class AppRoutes extends JvtdRoutes {
  static const String SPLASH_ROUTE_NAME = '/';
  static const String MAIN_ROUTE_NAME = '/main';
  static const String BUS_ROUTE_NAME = '/bus';
  static const String COLLECT_ROUTE_NAME = '/collect';

  @override
  List<RouterDefine> obtainRoutes() {
    return [
      RouterDefine(routeName: SPLASH_ROUTE_NAME, handler: RouterHandler.standard(page: SplashPage())),
      RouterDefine(routeName: MAIN_ROUTE_NAME, handler: RouterHandler.standard(page: MainPage()), transitionType: JvtdTransitionType.inFromRight),
      RouterDefine(routeName: COLLECT_ROUTE_NAME, handler: RouterHandler.standard(page: CollectPage()), transitionType: JvtdTransitionType.inFromRight),
      RouterDefine(
        routeName: BUS_ROUTE_NAME,
        handler: RouterHandler.params(handlerFunc: (context, parameters) {
          return BusPage(
            busId: parameters[RouteParams.BUS_ID]?.first,
            busName: ApiUtil.utf8Decode(parameters[RouteParams.BUS_NAME]?.first),
            stationId: parameters[RouteParams.STATION_ID]?.first,
            stationName: ApiUtil.utf8Decode(parameters[RouteParams.STATION_NAME]?.first),
          );
        }),
        transitionType: JvtdTransitionType.inFromRight,
      ),
    ];
  }
}
