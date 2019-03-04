import '../include.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends AppPageState<SplashPage> {
  @override
  bool get isDoubleClick => true;

  bool isGuide = false; //配置是否需要引导页

  @override
  StatusBarStyle get statusBarStyle => StatusBarStyle.DARK_CONTENT;

  TimerUtil _timerUtil; //计时器
  int _time = AppConfigs.SPLASH_TIME; //倒计时时间

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConstrainedBox(
          child: JvtdImage.local(
            name: AppImages.SPLASH,
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(), //填充父布局
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16, top: 16),
              child: FlatButton(
                shape: StadiumBorder(),
                padding: EdgeInsets.all(0),
                color: Colors.black26,
                onPressed: () {
                  _timeEnd();
                },
                child: Text(AppStrings.getLocale(context).skip + _time.toString() + "S",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //初始化计时器
  void _initTimer() {
    int sTime = 1000;
    int tTime = sTime * (_time + 1);
    if (_timerUtil == null) {
      _timerUtil = new TimerUtil(mInterval: sTime, mTotalTime: tTime);
    } else {
      _timerUtil.setInterval(sTime);
      _timerUtil.setTotalTime(tTime);
    }
    _timerUtil.setOnTimerCallback((int value) {
      _timeUpdate();
    });

    _timerUtil.startCountDown();
  }

  //取消计时器
  void _cancelTimer() {
    _time = AppConfigs.SPLASH_TIME;
    if (_timerUtil != null) _timerUtil.cancel();
  }

  //时间改变
  void _timeUpdate() {
    setState(() {
      _time--;
      if (_time < 0) {
        _time = 0;
        _timeEnd();
      }
    });
  }

  //时间改变结束，检验是否显示，界面刷新
  void _timeEnd() {
    _cancelTimer();
    _toApp();
  }

  //跳转APP
  void _toApp() {
    Application.router.navigateTo(context, AppRoutes.MAIN_ROUTE_NAME, replace: true);
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }
}
