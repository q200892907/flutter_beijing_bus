import 'package:amap_base/amap_base.dart';
import '../include.dart';

class MapUtil{
  static const String AMAP_IOS_KEY = '2bd6f79682b464346eb1619c1980602b';
  static const LatLng CHINA_LATLNG = LatLng(39.908692, 116.397477); //中国天安门
  static const int MAX_ZOOM = 20;
  static const int MIN_ZOOM = 3;

  static void init() async{
    await AMap.init(AMAP_IOS_KEY);
  }

  static int setZoom(
      {@required AMapController controller,
        @required int zoom,
        int maxZoom = MAX_ZOOM,
        int minZoom = MIN_ZOOM}) {
    zoom = zoom < minZoom ? minZoom : zoom;
    zoom = zoom > maxZoom ? maxZoom : zoom;
    controller?.setZoomLevel(zoom);
    return zoom;
  }

  static void setPosition({
    @required AMapController controller,
    @required LatLng latLng,
    double zoom,
  }) {
    if(zoom == null){
      controller?.setPosition(target: latLng);
    }else{
      controller?.setPosition(target: latLng, zoom: zoom);
    }
  }

  static void move({
    @required AMapController controller,
    @required LatLng latLng,
  }) {
    controller?.changeLatLng(latLng);
  }

  static void setMapType({
    @required AMapController controller,
    int type,
  }) {
    controller?.setMapType(type);
  }

  static void setMyLocation({
    @required AMapController controller,
    bool isOpen = true,
  }) {
    setMyLocationStyle(
        controller: controller,
        style: MyLocationStyle(
          showMyLocation: isOpen,
          myLocationType: LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER,
          strokeWidth: 0,
          strokeColor:const Color(0x00000000),
          radiusFillColor:const Color(0x00000000),
          showsAccuracyRing: false,
          interval: 10 * 1000,
          showsHeadingIndicator: true,
          locationDotFillColor: AppColors.COLOR_THEME,
        ));
  }

  static Future setMyLocationStyle({
    @required AMapController controller,
    @required MyLocationStyle style,
  }) async {
    if (await Permissions().requestPermission()) {
      controller?.setMyLocationStyle(style);
    }else{
      print('权限不足');
    }
  }

  static void setUiSettings({
    @required AMapController controller,
    UiSettings setting,
  }) {
    if (setting == null) {
      setting = UiSettings(
        isMyLocationButtonEnabled: false,
        isScaleControlsEnabled: false,
        isTiltGesturesEnabled: false,
        isZoomControlsEnabled: false,
        isCompassEnabled: false,
      );
    }
    controller?.setUiSettings(setting);
  }
}