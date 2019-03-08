import '../include.dart';
import 'package:latlong/latlong.dart';

class BusMapDialog extends BaseDialog {
  final BusBean bus;
  final List<LatLng> busLine;
  final List<StationBean> busStations;
  final List<RealTimeBusBean> busInfo;
  final String stationId;

  BusMapDialog({@required this.busLine, @required this.busStations, @required this.busInfo, @required this.stationId, @required this.bus,});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      constraints: BoxConstraints.expand(width: double.infinity,height: 480),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.COLOR_FFF,
      ),
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          _buildMap(context),
        ],
      ),
    );;
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(width: double.infinity, height: kTextTabBarHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        image: DecorationImage(image: JvtdImage.assetImage(name: AppImages.MAIN_BG), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              bus.startPoint,
              style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 14),
            ),
          ),
          Center(
            child: Text(
              bus.shotName + ' ' + AppStrings
                  .getLocale(context)
                  .busUnit,
              style: TextStyle(
                color: AppColors.COLOR_FFF,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              bus.endPoint,
              style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  _buildMap(BuildContext context) {
    return Container(
      height: 432,
      child: BusMapView(
          busLine: busLine,
          busInfo: busInfo,
          busStations: busStations,
          stationId: stationId,
        ),
    );
  }
}