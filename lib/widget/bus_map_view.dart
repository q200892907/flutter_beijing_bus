import '../include.dart';
import 'package:latlong/latlong.dart';

class BusMapView extends StatefulWidget {
  final EdgeInsets controlsPadding; //控件偏移
  final bool isShowLocationControls; //是否显示定位控件
  final double iconSize;
  final List<LatLng> busLine;
  final List<StationBean> busStations;
  final List<RealTimeBusBean> busInfo;
  final String stationId;

  const BusMapView({
    Key key,
    this.controlsPadding = const EdgeInsets.all(8),
    this.isShowLocationControls = true,
    this.iconSize = 40,
    @required this.busLine,
    @required this.busStations,
    @required this.busInfo,
    @required this.stationId,
  }) : super(key: key);

  @override
  _BusMapViewState createState() => _BusMapViewState();
}

class _BusMapViewState extends State<BusMapView> {
  MapController _controller;
  int _zoom = 17;
  LatLng _currentLatLng;
  LatLng _swLatLng;
  LatLng _neLatLng;
  double _currentZoom = 17;
  bool _isFirst = true;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  double _getScale() {
    return _currentZoom / _zoom;
  }

  @override
  Widget build(BuildContext context) {
    _toStation();
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FlutterMap(
            options: MapOptions(
              center: _currentLatLng,
              zoom: _zoom.floorToDouble(),
              maxZoom: 19,
              minZoom: 13,
              onPositionChanged: _changed,
              swPanBoundary: _swLatLng,
              nePanBoundary: _neLatLng,
            ),
            mapController: _controller,
            layers: [
              TileLayerOptions(
                urlTemplate: 'http://webrd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}', //瓦片地图的URL
                subdomains: ["1", "2", "3", "4"],
              ),
              PolylineLayerOptions(
                polylines: [
                  Polyline(points: widget.busLine, color: AppColors.COLOR_THEME, strokeWidth: 5 * _getScale()),
                ],
              ),
              MarkerLayerOptions(
                markers: widget.busStations.map((item) {
                  return Marker(
                    builder: (context) {
                      return JvtdImage.local(name: item.no == widget.stationId ? AppImages.BUS_STATION_CURRENT : AppImages.BUS_STATION);
                    },
                    point: LatLng(double.parse(item.lat), double.parse(item.lon)),
                    width: 30 * _getScale(),
                    height: 30 * _getScale(),
                  );
                }).toList(),
              ),
              MarkerLayerOptions(
                markers: widget.busInfo == null
                    ? []
                    : widget.busInfo.map((item) {
                        return Marker(
                          builder: (context) {
                            return JvtdImage.local(name: AppImages.BUS_RED);
                          },
                          point: LatLng(double.parse(item.lat), double.parse(item.lon)),
                          width: 20 * _getScale(),
                          height: 20 * _getScale(),
                        );
                      }).toList(),
              ),
            ],
          ),
        ),
        _buildControls(context),
      ],
    );
  }

  void _toStation() {
    double maxLat;
    double minLat;
    double maxLon;
    double minLon;
    int i=0;
    for (StationBean value in widget.busStations) {
      if(i==0){
        maxLat = double.parse(value.lat);
        minLat = maxLat;
        maxLon = double.parse(value.lon);
        minLon = maxLon;
      }else{
        maxLat = max(maxLat, double.parse(value.lat));
        minLat = min(minLat, double.parse(value.lat));
        maxLon = max(maxLon, double.parse(value.lon));
        minLon = min(minLon, double.parse(value.lon));
      }
      i++;
      if (value.no == widget.stationId) {
        _currentLatLng = LatLng(double.parse(value.lat), double.parse(value.lon));
      }
    }
    _swLatLng = LatLng(minLat, minLon);
    _neLatLng = LatLng(maxLat, maxLon);
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      padding: widget.controlsPadding,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildLocationControls(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLocationControls(BuildContext context) {
    return [
      IconButton(
        icon: JvtdImage.local(name: AppImages.MAP_LOCATION),
        iconSize: widget.iconSize,
        onPressed: () {
          toCurrentLocation();
        },
      )
    ];
  }

  void toCurrentLocation() {
    _toStation();
    _controller.move(_currentLatLng, _currentZoom.floorToDouble());
  }

  _changed(MapPosition position, bool hasGesture) {
    if (_isFirst) {
      _isFirst = false;
      return;
    }
    _currentLatLng = position.center;
    _currentZoom = position.zoom;
    setState(() {});
  }
}
