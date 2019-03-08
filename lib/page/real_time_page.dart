import '../include.dart';
import '../widget/bus_dialog.dart';
import '../widget/bus_direction_dialog.dart';
import '../widget/bus_stations_dialog.dart';
import '../widget/bus_collect_list_view.dart';

class RealTimePage extends StatefulWidget {
  @override
  _RealTimePageState createState() => _RealTimePageState();
}

class _RealTimePageState extends State<RealTimePage> with AutomaticKeepAliveClientMixin {
  BusType _busType = BusType.NORMAL;
  String _lineName = '';
  LineBean _selectLine;
  String _lineDirection = '';
  GetBusApi _getBusApi;
  BusBean _busBean;
  String _lineStation = '';
  StationBean _stationBean;

  JvtdLoadingDialog _loadingDialog;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLines();
  }

  void _getLines() {
    BusUtil.instance.initLines(context, (success) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildQuery(),
        _buildCollect(),
      ],
    );
  }

  Widget _buildQuery() {
    return Card(
      elevation: 16,
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      color: AppColors.COLOR_FFF,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: BusUtil.instance.allLines == null || BusUtil.instance.allLines.length == 0
          ? _buildLoading()
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppButton.realTime(
                    AppImages.LINE,
                    AppStrings.getLocale(context).line,
                    hintText: AppStrings.getLocale(context).pleaseSelectLine,
                    text: _lineName.isEmpty ? _lineName : _lineName + ' ' + AppStrings.getLocale(context).busUnit,
                    onPressed: _selectBus,
                  ),
                  AppButton.realTime(
                    AppImages.DIRECTION,
                    AppStrings.getLocale(context).direction,
                    hintText: AppStrings.getLocale(context).pleaseSelectDirection,
                    text: _lineDirection,
                    onPressed: _selectDirection,
                  ),
                  _lineDirection.isEmpty
                      ? Container()
                      : AppButton.realTime(
                          AppImages.STATION,
                          AppStrings.getLocale(context).station,
                          hintText: AppStrings.getLocale(context).pleaseSelectStation,
                          text: _lineStation,
                          onPressed: _selectStation,
                        ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      disabledColor: AppColors.COLOR_CCC,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: AppColors.COLOR_THEME,
                      onPressed: _stationBean != null ? _query : null,
                      child: Text(
                        AppStrings.getLocale(context).query,
                        style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildLoading() {
    return Container(
      constraints: BoxConstraints.expand(width: double.infinity, height: 180),
      alignment: Alignment.center,
      child: BusUtil.instance.allLines == null
          ? SpinKitCircle(
              color: AppColors.COLOR_THEME,
              size: 64,
            )
          : VerticalButton.icon(
              space: 16,
              onPressed: () {
                setState(() {
                  BusUtil.instance.allLines = null;
                });
                _getLines();
              },
              icon: JvtdImage.local(name: AppImages.ICON, color: AppColors.COLOR_THEME, width: 64, height: 64),
              label: Text(
                AppStrings.getLocale(context).loadErrorClickRetry,
                style: TextStyle(color: AppColors.COLOR_999, fontSize: 12),
              ),
            ),
    );
  }

  Widget _buildCollect() {
    return Expanded(
      child: BusCollectListView(
        isProminent: true,
      ),
    );
  }

  void _selectBus() {
    showJvtdDialog(
      context: context,
      builder: (context) {
        return BusDialog(
          onSelected: (busName, busType) {
            if (_lineName != busName) {
              _clearDirection();
              _clearStation();
            }
            _busType = busType;
            _lineName = busName;
            setState(() {});
          },
          busType: _busType,
        );
      },
    );
  }

  void _clearStation() {
    _busBean = null;
    _lineStation = '';
  }

  void _clearDirection() {
    _lineDirection = '';
    _selectLine = null;
  }

  void _selectDirection() {
    if (_lineName.isEmpty) {
      JvtdToast.showMessage(msg: AppStrings.getLocale(context).pleaseSelectLine);
      return;
    }
    showJvtdDialog(
      context: context,
      builder: (context) {
        return BusDirectionDialog(
          onSelected: (line) {
            if (_selectLine != null && line.id != _selectLine.id) {
              _clearStation();
            }
            _selectLine = line;
            _lineDirection = line.lineDirection;
            setState(() {});
          },
          busType: _busType,
          lineName: _lineName,
        );
      },
    );
  }

  void showLoading() {
    if (_loadingDialog == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            _loadingDialog = JvtdLoadingDialog();
            return _loadingDialog;
          });
    }
  }

  void hideLoading() {
    if (_loadingDialog != null) {
      _loadingDialog.close(context);
      _loadingDialog = null;
    }
  }

  void _selectStation() {
    if (_getBusApi == null) {
      _getBusApi = GetBusApi(context);
    }
    if (_busBean == null) {
      showLoading();
      _getBusApi.start(GetBusReqBean(id: _selectLine.id).toJson()).then((value) {
        hideLoading();
        if (value.success) {
          _busBean = value.result;
          _showStationsDialog();
        } else {
          JvtdToast.showMessage(msg: value.message);
        }
      });
    } else {
      _showStationsDialog();
    }
  }

  void _showStationsDialog() {
    showJvtdDialog(
      context: context,
      builder: (context) {
        return BusStationsDialog(
          onSelected: (station) {
            _stationBean = station;
            _lineStation = _stationBean.name;
            setState(() {});
          },
          bus: _busBean,
        );
      },
    );
  }

  void _query() {
    Map<String, String> params = Map();
    params[RouteParams.BUS_ID] = _busBean.lineId;
    params[RouteParams.BUS_NAME] = ApiUtil.utf8Encode(_busBean.shotName);
    params[RouteParams.STATION_ID] = _stationBean.no;
    params[RouteParams.STATION_NAME] = ApiUtil.utf8Encode(_stationBean.name);
    Application.router.navigateTo(context, AppRoutes.BUS_ROUTE_NAME + mapToRouteParams(params));
  }
}
