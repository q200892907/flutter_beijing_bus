import '../include.dart';

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
  AMapController _controller;
  AMapOptions _mapOptions;
  int _zoom = 17;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BusMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateMarker();
  }

  @override
  Widget build(BuildContext context) {
    _mapOptions = AMapOptions(
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      rotateGesturesEnabled: false,
      //缩放控件关闭
      scaleControlsEnabled: false,
      //比例尺关闭
      tiltGesturesEnabled: false,
      //3D模式关闭
      compassEnabled: false,
      //指北针
      mapType: MAP_TYPE_NORMAL,
      //地图模式
      myLocationEnabled: true,
    );
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AMapView(
            amapOptions: _mapOptions,
            onAMapViewCreated: (controller) {
              _controller = controller;
              MapUtil.setZoom(controller: _controller, zoom: _zoom); //地图创建成功默认17级
              MapUtil.setUiSettings(controller: _controller); //iOS二次设置
              _controller.addPolyline(PolylineOptions(latLngList: widget.busLine == null ? [] : widget.busLine, width: 10, color: AppColors.COLOR_THEME));
              _controller.clearMarkers();
              for (StationBean value in widget.busStations) {
                LatLng latLng = LatLng(double.parse(value.lat), double.parse(value.lon));
                if (value.no == widget.stationId) {
                  MapUtil.move(controller: _controller, latLng: latLng);
                }
                _controller.addMarker(
                  MarkerOptions(
                    position: latLng,
                    icon: value.no == widget.stationId ? JvtdImage.imagePath(name: AppImages.BUS_STATION_CURRENT) : JvtdImage.imagePath(name: AppImages.BUS_STATION),
                    enabled: false,
                  ),
                );
              }
            },
          ),
        ),
        _buildControls(context),
      ],
    );
  }

  void _updateMarker(){
    if(widget.busInfo == null || widget.busInfo.isEmpty) return;
    _controller.clearMarkers();
    for (StationBean value in widget.busStations) {
      LatLng latLng = LatLng(double.parse(value.lat), double.parse(value.lon));
      _controller.addMarker(
        MarkerOptions(
          position: latLng,
          icon: value.no == widget.stationId ? JvtdImage.imagePath(name: AppImages.BUS_STATION_CURRENT) : JvtdImage.imagePath(name: AppImages.BUS_STATION),
          enabled: false,
        ),
      );
    }
    widget.busInfo.forEach((value) {
      _controller.addMarker(
        MarkerOptions(
            position: LatLng(
              double.parse(value.lat),
              double.parse(value.lon),
            ),
            icon: JvtdImage.imagePath(name: AppImages.BUS_RED),
            enabled: false),
      );
    });
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      padding: widget.controlsPadding,
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildLocationControls(context),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _buildRightControls(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLocationControls(BuildContext context) {
    return [
//      IconButton(
//        icon: JvtdImage.local(name: AppImages.MAP_LOCATION),
//        iconSize: widget.iconSize,
//        onPressed: () {
//          toCurrentLocation();
//        },
//      )
    ];
  }

  void toCurrentLocation() async {
    //todo 移动当前位置有问题
    LatLng latLng = await _controller.getCenterLatlng();
    MapUtil.setPosition(controller: _controller, latLng: latLng, zoom: _zoom.toDouble());
//    GsaMapUtils.move(controller: _controller, latLng: latLng);
  }

  List<Widget> _buildRightControls(BuildContext context) {
    List<Widget> rightWidgets = <Widget>[];
    rightWidgets.add(
      IconButton(
        icon: JvtdImage.local(name: AppImages.MAP_ADD),
        iconSize: widget.iconSize,
        onPressed: () {
          _zoom = MapUtil.setZoom(controller: _controller, zoom: ++_zoom);
        },
        padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
      ),
    );
    rightWidgets.add(
      IconButton(
        icon: JvtdImage.local(name: AppImages.MAP_SUB),
        iconSize: widget.iconSize,
        onPressed: () {
          _zoom = MapUtil.setZoom(controller: _controller, zoom: --_zoom);
        },
        padding: EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 8),
      ),
    );
    return rightWidgets;
  }
}
