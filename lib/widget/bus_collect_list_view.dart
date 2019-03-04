import '../include.dart';
import 'bus_collect_view.dart';

class BusCollectListView extends StatefulWidget {
  final bool isProminent;

  const BusCollectListView({Key key, this.isProminent = false}) : super(key: key);

  @override
  _BusCollectListViewState createState() => _BusCollectListViewState();
}

class _BusCollectListViewState extends AppListViewState<CollectBusBean, BusCollectListView> {
  @override
  bool get isLoadMore => false;

  TimerUtil _timerUtil; //计时器
  GetRealTimeBusListTwoApi _getRealTimeBusListTwoApi;
  List<RealTimeBusBean> _realTimeBusList;

  @override
  void initState() {
    super.initState();
    Application.eventBus.on<CollectBusListUpdateEvent>().listen((data) {
      if (widget.isProminent) {
        _getCollectBus();
      }
    });
    Application.eventBus.on<CollectBusUpdateEvent>().listen((data) {
      _getCollectBus();
    });
  }

  @override
  void dispose() {
    _closeTimer();
    super.dispose();
  }

  @override
  Widget buildItemWidget(BuildContext context, int position) {
    return BusCollectView(
        bus: listData[position],
        realTimeBus: _realTimeBusList != null && _realTimeBusList[position] != null && !_realTimeBusList[position].isEmpty() ? _realTimeBusList[position] : null,
        icon: !widget.isProminent,
        prominentUpdate: () {
          setState(() {});
        });
  }

  void _startTimer() {
    if (_timerUtil == null) {
      _timerUtil = TimerUtil(mInterval: AppConfigs.UPDATE_TIME);
    }
    _timerUtil.setOnTimerCallback((time) {
      if (listData.length > 0) {
        _getRealTimeBusList();
      }
    });
    _timerUtil.startTimer();
  }

  void _closeTimer() {
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
  }

  void _getCollectBus() async {
    _closeTimer();
    List<CollectBusBean> list = await SqliteUtil.instance.collectProvider.queryAll(widget.isProminent);
    loadData(loadData: list);
    _startTimer();
  }

  @override
  Future onRefresh() async {
    _getCollectBus();
  }

  @override
  BaseEmptyView buildEmptyView() {
    return JvtdEmptyView(
      loadingColor: AppColors.COLOR_THEME,
      emptyStatus: emptyStatus,
      errorText: AppStrings.getLocale(context).loadErrorClickRetry,
      isList: true,
      onErrorPressed: () {
        onRefresh();
      },
      iconName: AppImages.ICON,
      emptyText: widget.isProminent ? AppStrings.getLocale(context).youNotHome : AppStrings.getLocale(context).youNotCollect,
      emptyImgName: AppImages.ICON,
    );
  }

  void _getRealTimeBusList() {
    if (_getRealTimeBusListTwoApi == null) _getRealTimeBusListTwoApi = GetRealTimeBusListTwoApi(context);
    String query = '';
    int i = 0;
    listData.forEach((item) {
      i++;
      query += item.busId + '@@@' + item.stationId + '@@@' + item.stationName;
      if (i < listData.length) {
        query += '|||';
      }
    });
    _getRealTimeBusListTwoApi.start(GetRealTimeBusReqTwoBean(query: query).toJson()).then((data) {
      if (data.success) {
        List<RealTimeBusBean> busBeans = data.result;
        _realTimeBusList = [];
        listData.forEach((item) {
          RealTimeBusBean bus = RealTimeBusBean();
          for (int i = 0; i < busBeans.length; i++) {
            RealTimeBusBean bean = busBeans[i];
            if (item.stationId == bean.stationNo) {
              bus = bean;
              busBeans.removeAt(i);
              break;
            }
          }
          _realTimeBusList.add(bus);
        });
        setState(() {});
      }
    });
  }
}
