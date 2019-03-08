import '../include.dart';

class BusCollectView extends StatelessWidget {
  final CollectBusBean bus;
  final RealTimeBusBean realTimeBus;
  final VoidCallback prominentUpdate;
  final bool icon;

  const BusCollectView({
    Key key,
    @required this.bus,
    this.realTimeBus,
    this.icon = true,
    @required this.prominentUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Map<String, String> params = Map();
        params[RouteParams.BUS_ID] = bus.busId;
        params[RouteParams.BUS_NAME] = ApiUtil.utf8Encode(bus.busName);
        params[RouteParams.STATION_ID] = bus.stationId;
        params[RouteParams.STATION_NAME] = ApiUtil.utf8Encode(bus.stationName);
        Application.router.navigateTo(context, AppRoutes.BUS_ROUTE_NAME + mapToRouteParams(params));
      },
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppColors.COLOR_FFF,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.2,
              child: Container(
                padding: EdgeInsets.only(top: 24),
                alignment:Alignment.centerRight,
                child: JvtdImage.local(name: AppImages.BUS_INFO_BG,color: AppColors.COLOR_THEME,height: 100,width: 50),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  _buildBusAndStation(context),
                  SizedBox(height: 16),
                  _buildRealTimeBusInfo(context),
                  SizedBox(height: 8),
                  _buildDottedLine(),
                  SizedBox(height: 8),
                  _buildPoints(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //创建公交和站点信息 收藏按钮
  Widget _buildBusAndStation(BuildContext context) {
    return Row(
      children: <Widget>[
        JvtdImage.local(name: AppImages.BUS, width: 16, height: 16, fit: BoxFit.contain, color: AppColors.COLOR_FF6053),
        SizedBox(width: 8),
        Text(
          bus.busName,
          style: TextStyle(color: AppColors.COLOR_FF6053, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          AppStrings.getLocale(context).fromThe,
          style: TextStyle(color: AppColors.COLOR_999, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            bus.stationName,
            style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          constraints: BoxConstraints.expand(width: 20, height: 20),
          child: icon ? IconButton(
            padding: EdgeInsets.zero,
            iconSize: 20,
            icon: Icon(
              Icons.home,
              color: bus.home != CollectType.NORMAL.index ? AppColors.COLOR_THEME : AppColors.COLOR_999,
            ),
            onPressed: () {
              _updateCollectBus();
            },
          ):null,
        ),
      ],
    );
  }

  Widget _buildPoints() {
    return Row(
      children: <Widget>[
        Text(
          bus.start,
          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward, size: 14, color: AppColors.COLOR_333),
        SizedBox(width: 8),
        Text(
          bus.end,
          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  //虚线
  Widget _buildDottedLine() => Text(
        '--------------------------------------------------------------------------------------------------------------',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.COLOR_E8E8E8),
        maxLines: 1,
      );

  Widget _buildRealTimeBusInfo(BuildContext context) {
    if (realTimeBus != null) {
      BusStatus busStatus = realTimeBus.busStatus(bus.stationId);
      if (busStatus == BusStatus.ARRIVE) {
        return Container(
          height: 24,
          alignment: Alignment.centerLeft,
          child: ColorizeAnimatedTextKit(
            alignment: AlignmentDirectional.centerStart,
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            text: <String>[
              AppStrings.getLocale(context).busArrive,
            ],
            colors: AppColors.ANIMATED_COLORS,
          ),
        );
      } else if (busStatus == BusStatus.WILL_ARRIVE) {
        return Container(
          height: 24,
          alignment: Alignment.centerLeft,
          child: ColorizeAnimatedTextKit(
            alignment: AlignmentDirectional.centerStart,
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            text: <String>[
              AppStrings.getLocale(context).busWillArrive,
            ],
            colors: AppColors.ANIMATED_COLORS,
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildInfoAndTitle(context, AppStrings.getLocale(context).standing, realTimeBus == null ? AppConfigs.STATION_NUM_PLACEHOLDER : realTimeBus.arrivedStationNum(bus.stationId).toString()),
        _buildInfoAndTitle(context, AppStrings.getLocale(context).km, realTimeBus == null ? AppConfigs.DISTANCE_PLACEHOLDER : realTimeBus.stationDistince),
        _buildInfoAndTitle(context, AppStrings.getLocale(context).arrive, realTimeBus == null ? AppConfigs.TIME_PLACEHOLDER : realTimeBus.stationTime, AppStrings.getLocale(context).expect),
      ],
    );
  }

  Widget _buildInfoAndTitle(BuildContext context, String title, String info, [String tips]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        tips != null
            ? Text(
                tips,
                style: TextStyle(color: AppColors.COLOR_333, fontSize: 14),
              )
            : Container(),
        SizedBox(width: tips != null ? 4 : 0),
        Text(
          info,
          style: TextStyle(color: AppColors.COLOR_THEME, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14),
        ),
      ],
    );
  }

  void _updateCollectBus() async {
    _updateType();
    int num = await SqliteUtil.instance.collectProvider.update(bus);
    if (num > 0) {
      prominentUpdate();
    } else {
      _updateType();
    }
  }

  void _updateType() {
    if (bus.home != CollectType.NORMAL.index) {
      bus.home = CollectType.NORMAL.index;
    } else {
      bus.home = CollectType.PROMINENT.index;
    }
  }
}
