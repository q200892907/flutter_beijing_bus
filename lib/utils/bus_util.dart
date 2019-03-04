import '../include.dart';

typedef OnBusCallBack = void Function(bool success);

enum BusType {
  NORMAL, //普通
  EXPRESS, //运通
  NIGHT, //夜间
  AIRPORT, //机场
}

class BusUtil {
  // 工厂模式
  factory BusUtil() => _getInstance();

  static BusUtil get instance => _getInstance();
  static BusUtil _instance;

  BusUtil._internal() {
    // 初始化
  }
  static BusUtil _getInstance() {
    if (_instance == null) {
      _instance = new BusUtil._internal();
    }
    return _instance;
  }
  static Color busColor(int pos) {
    if (pos % 3 == 0) {
      return AppColors.COLOR_69A5FF;
    } else if (pos % 3 == 1) {
      return AppColors.COLOR_FF796E;
    }
    return AppColors.COLOR_FFB94B;
  }

  GetLinesApi _getLinesApi;
  List<LineBean> _allLines;
  Map<BusType, List<Map<String, List<LineBean>>>> _busList;

  Map<BusType, List<Map<String, List<LineBean>>>> get allBus => _busList;

  List<LineBean> get allLines => _allLines;

  set allLines(List<LineBean> value) {
    _allLines = value;
  }

  List<Map<String,List<LineBean>>> query(String query)
  {
    List<Map<String,List<LineBean>>> busBeans = [];
    allBus.forEach((type,list){
      list.forEach((value){
        value.keys.forEach((name){
          if(name.contains(query)){
            busBeans.add(value);
          }
        });
      });
    });
    return busBeans;
  }

  //获取当前离我最近的bus
  static RealTimeBusBean realTimeBus(List<RealTimeBusBean> all,String stationId) {
    RealTimeBusBean realTimeBusBean;
    for (int i = 0; i < all.length; i++) {
      RealTimeBusBean bean = all[i];
      if(bean.nextStationNo == stationId){
        return bean;
      }
      if (double.parse(bean.stationDistince) > 0) {
        if (realTimeBusBean == null) realTimeBusBean = bean;
        if (realTimeBusBean != null && double.parse(bean.stationDistince) < double.parse(realTimeBusBean.stationDistince)) {
          realTimeBusBean = bean;
        }
      }
    }
    return realTimeBusBean;
  }

  void initLines(BuildContext context, OnBusCallBack callback) {
    if (_allLines != null && _allLines.length != 0) {
      callback(true);
      return;
    }
    if (_getLinesApi == null) _getLinesApi = GetLinesApi(context);
    _getLinesApi.start().then((value) {
      if (value.success) {
        _allLines = value.result;
        _busList = Map();
        _busList[BusType.NORMAL] = [];
        _busList[BusType.EXPRESS] = [];
        _busList[BusType.NIGHT] = [];
        _busList[BusType.AIRPORT] = [];

        String tempName = '';
        BusType type;
        List<LineBean> tempLines;
        _allLines.forEach((bean) {
          if(bean.isOperating()) {
            if (tempName != bean.lineShortName) {
              if (type != null) {
                _busList[type].add({
                  tempName: tempLines,
                });
              }
              tempLines = [];
              type = bean.busType(context);
              tempName = bean.lineShortName;
            }
            tempLines.add(bean);
          }
        });
        if (_allLines.length == 0) {
          _allLines = null;
          callback(false);
        } else {
          callback(true);
        }
      } else {
        _allLines = null;
        callback(false);
      }
    });
  }
}
