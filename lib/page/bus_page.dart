import '../include.dart';

class BusPage extends StatefulWidget {
  final String busId;
  final String busName;
  final String stationId;
  final String stationName;

  const BusPage({
    Key key,
    this.busId,
    this.busName,
    this.stationId,
    this.stationName,
  }) : super(key: key);

  @override
  _BusPageState createState() => _BusPageState();
}

class _BusPageState extends AppPageState<BusPage> {
  GetBusApi _getBusApi;
  BusBean _busBean;
  CollectBusBean _collectBus;
  int _stationNum = -1; //当前还有几站
  String _distance = AppConfigs.DISTANCE_PLACEHOLDER; //距离站点公里
  String _time = AppConfigs.TIME_PLACEHOLDER; //预计到达时间

  TimerUtil _timerUtil; //计时器
  GetRealTimeBusListApi _getRealTimeBusListApi;
  List<RealTimeBusBean> _allBus;
  RealTimeBusBean _realTimeBus;
  List<StationBean> _stations;
  ScrollController _scrollController;

  @override
  String appBarTitle(BuildContext context) {
    return AppStrings.getLocale(context).realTimeQuery;
  }

  @override
  void initData(BuildContext context) {
    super.initData(context);
    _scrollController = ScrollController();
    _getBusInfo();
    _queryCollect();
  }

  @override
  void dispose() {
    _closeTimer();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(width: double.infinity, height: double.infinity),
            child: JvtdImage.local(name: AppImages.BUS_BG),
          ),
          Column(
            children: <Widget>[
              _buildBus(context),
              _buildAllBus(),
            ],
          )
        ],
      ),
    );
  }

  Expanded _buildAllBus() {
    return _busBean != null
        ? Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 150,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, pos) {
                    StationBean stationBean = _stations[pos];
                    StationType type;
                    if (stationBean.isStation()) {
                      if (int.parse(stationBean.no) < int.parse(widget.stationId)) {
                        type = StationType.BEFORE;
                      } else if (int.parse(stationBean.no) > int.parse(widget.stationId)) {
                        type = StationType.AFTER;
                      } else {
                        type = StationType.CURRENT;
                      }
                    }
                    return Stack(
                      children: <Widget>[
                        stationBean.isStation()
                            ? Stack(
                                children: <Widget>[
                                  StationBoard(
                                    line: _busBean.shotName,
                                    type: type,
                                    name: stationBean.name,
                                    width: type == StationType.CURRENT ? 150 : 100,
                                  ),
                                  Container(
                                    width: type == StationType.CURRENT ? 150 : 100,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: JvtdImage.local(
                                        name: AppImages.BUS_CROSS,
                                        color: stationBean.stationBus != null && stationBean.stationBus.length > 0 ? AppColors.COLOR_FFAD2C : Colors.transparent,
                                        fit: BoxFit.contain,
                                        width: type == StationType.CURRENT ? 120 : 80,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                width: pos == 0 || pos == _stations.length - 1 ? 16 : 80,
                                child: pos == 0 || pos == _stations.length - 1
                                    ? null
                                    : Align(
                                        alignment: Alignment.bottomCenter,
                                        child: JvtdImage.local(
                                            name: AppImages.BUS_CROSS,
                                            color: stationBean.stationBus != null && stationBean.stationBus.length > 0 ? AppColors.COLOR_FF6053 : Colors.transparent,
                                            width: 60,
                                            fit: BoxFit.contain),
                                      ),
                              ),
                      ],
                    );
                  },
                  itemCount: _stations.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          )
        : Expanded(
            child: Container(),
          );
  }

  Widget _buildBus(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.COLOR_FFF,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildBusAndStation(context),
            SizedBox(height: 16),
            _buildRealTimeBusInfo(context),
            SizedBox(height: 8),
            _buildDottedLine(),
            SizedBox(height: 8),
            _busBean != null ? _buildPoints() : Container(),
            SizedBox(height: _busBean != null ? 4 : 0),
            _busBean != null ? _buildTime(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildRealTimeBusInfo(BuildContext context) {
    if (_realTimeBus != null) {
      BusStatus busStatus = _realTimeBus.busStatus(widget.stationId);
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
        _buildInfoAndTitle(context, AppStrings.getLocale(context).standing, _stationNum < 0 ? AppConfigs.STATION_NUM_PLACEHOLDER : _stationNum.toString()),
        _buildInfoAndTitle(context, AppStrings.getLocale(context).km, _distance),
        _buildInfoAndTitle(context, AppStrings.getLocale(context).arrive, _time, AppStrings.getLocale(context).expect),
      ],
    );
  }

  Widget _buildPoints() {
    return Row(
      children: <Widget>[
        Text(
          _busBean.startPoint,
          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward, size: 14, color: AppColors.COLOR_333),
        SizedBox(width: 8),
        Text(
          _busBean.endPoint,
          style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTime(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          AppStrings.getLocale(context).firstBus + ' ' + _busBean.firstTime,
          style: TextStyle(color: AppColors.COLOR_999, fontSize: 12),
        ),
        SizedBox(width: 8),
        Text(
          AppStrings.getLocale(context).endBus + ' ' + _busBean.endTime,
          style: TextStyle(color: AppColors.COLOR_999, fontSize: 12),
        ),
        SizedBox(width: 24),
        Text(
          _busBean.ticket,
          style: TextStyle(color: AppColors.COLOR_999, fontSize: 12),
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

  //创建公交和站点信息 收藏按钮
  Widget _buildBusAndStation(BuildContext context) {
    return Row(
      children: <Widget>[
        JvtdImage.local(name: AppImages.BUS, width: 16, height: 16, fit: BoxFit.contain, color: AppColors.COLOR_FF6053),
        SizedBox(width: 8),
        Text(
          _busBean != null ? _busBean.shotName : widget.busName,
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
            widget.stationName,
            style: TextStyle(color: AppColors.COLOR_333, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          constraints: BoxConstraints.expand(width: 20, height: 20),
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 20,
            icon: Icon(
              _collectBus != null ? Icons.star : Icons.star_border,
              color: _collectBus != null ? AppColors.COLOR_FFAD2C : AppColors.COLOR_999,
            ),
            onPressed: _busBean == null
                ? null
                : () {
                    if (_collectBus != null) {
                      _cancelCollect();
                    } else {
                      _addCollect();
                    }
                  },
          ),
        ),
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

  void _getBusInfo() {
    if (_getBusApi == null) {
      _getBusApi = GetBusApi(context);
    }
    _getBusApi.start(GetBusReqBean(id: widget.busId).toJson()).then((value) {
      if (value.success) {
        _busBean = value.result;
        _stations = [];
        for (int i = 0; i < _busBean.stations.station.length; i++) {
          if (i == 0) {
            _stations.add(StationBean());
          }
          _stations.add(_busBean.stations.station[i]);
          if(i < _busBean.stations.station.length - 1) {
            _stations.add(StationBean(no: _busBean.stations.station[i+1].no));
          }
        }
        _startTimer();
        setState(() {});
        _toCurrentStation();
      }
    });
  }

  void _getBusList() {
    if (_getRealTimeBusListApi == null) {
      _getRealTimeBusListApi = GetRealTimeBusListApi(context);
    }
    _getRealTimeBusListApi.start(GetRealTimeBusReqBean(id: widget.busId, no: widget.stationId).toJson()).then((value) {
      if (value.success) {
        _allBus = value.result;
      } else {
        _allBus = null;
      }
      _updateBusInfo();
      setState(() {});
    });
  }

  void _startTimer() {
    if (_timerUtil == null) {
      _timerUtil = TimerUtil(mInterval: AppConfigs.UPDATE_TIME);
    }
    _timerUtil.setOnTimerCallback((time) {
      if (_stations != null) {
        _getBusList();
      }
    });
    _timerUtil.startTimer();
  }

  void _closeTimer() {
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
  }

  void _updateBusInfo() {
    _stationNum = -1;
    _time = AppConfigs.TIME_PLACEHOLDER;
    _distance = AppConfigs.DISTANCE_PLACEHOLDER;
    if (_allBus != null && _allBus.length > 0) {
      _realTimeBus = BusUtil.realTimeBus(_allBus, widget.stationId);
      if (_realTimeBus != null) {
        _stationNum = _realTimeBus.arrivedStationNum(widget.stationId);
        _time = _realTimeBus.stationTime;
        _distance = _realTimeBus.stationDistince;
      }
      _stations.forEach((item) {
        item.stationBus = [];
        if (item.no != null) {
          _allBus.forEach((item1) {
            if (item1.nextStationNo == item.no) {
              if (item1.busStatusForNextStation() == BusStatus.ARRIVE && item.isStation()) {
                item.addBus(item1);
              } else if(item1.busStatusForNextStation() != BusStatus.ARRIVE && !item.isStation()){
                item.addBus(item1);
              }
            }
          });
        }
      });
    } else {
      _stations.forEach((item) {
        item.stationBus = [];
      });
    }
  }

  void _queryCollect() async {
    _collectBus = await SqliteUtil.instance.collectProvider.query(widget.busId, widget.stationId);
    setState(() {});
  }

  void _cancelCollect() async {
    int success = await SqliteUtil.instance.collectProvider.delete(_collectBus.busId, _collectBus.stationId);
    Application.eventBus.fire(CollectBusUpdateEvent(_collectBus));
    if (success > 0) {
      _collectBus = null;
    }
    setState(() {});
  }

  void _addCollect() async {
    CollectBusBean collectBusBean = CollectBusBean(
      busId: _busBean.lineId,
      busName: _busBean.shotName,
      stationId: widget.stationId,
      stationName: widget.stationName,
      start: _busBean.startPoint,
      end: _busBean.endPoint,
      home: CollectType.NORMAL.index,
    );
    _collectBus = await SqliteUtil.instance.collectProvider.insert(collectBusBean);
    setState(() {});
    Application.eventBus.fire(CollectBusUpdateEvent(_collectBus,true));
  }

  void _toCurrentStation() async{
    double offset = 0;
    int id = int.parse(widget.stationId);
    offset = 16.0 + (id-2) * 180;
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(offset, duration: Duration(milliseconds: 100), curve: Curves.linear);
    });
  }
}
