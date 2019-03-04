import 'package:flutter/material.dart';
import 'app_enum.dart';

export 'app_enum.dart';

// 基础配置类
class AppConfigs {
  //配置环境信息
  static const Environment ENVIRONMENT_TYPE = Environment.DEVELOPMENT;

  //基础网址 分为开发、测试、生产
  static const String HTTP_URL_DEVELOPMENT = "http://transapp.btic.org.cn:8512"; //开发环境
  static const String HTTP_URL_TEST = "http://transapp.btic.org.cn:8512"; //测试环境
  static const String HTTP_URL_PRODUCTION = "http://transapp.btic.org.cn:8512"; //生产环境
  //获取网络路径地址
  static String getHttpUrl() {
    switch (ENVIRONMENT_TYPE) {
      case Environment.DEVELOPMENT:
        return HTTP_URL_DEVELOPMENT;
      case Environment.TEST:
        return HTTP_URL_TEST;
      case Environment.PRODUCTION:
        return HTTP_URL_PRODUCTION;
    }
    return HTTP_URL_DEVELOPMENT;
  }

  //接口地址
  static String getHttpApiUrl() {
    return getHttpUrl();
  }

  static const String IMAGE_URL = ""; //图片前缀地址

  static const int SPLASH_TIME = 3; //闪屏页时间

  static const Duration PAGE_TRANSITION_DURATION = Duration(milliseconds: 400); //跳转时间

  static const String DISTANCE_PLACEHOLDER = '--';
  static const String STATION_NUM_PLACEHOLDER = '--';
  static const String TIME_PLACEHOLDER = '--:--';
  static const String STRING_PLACEHOLDER = '???';

  static const int UPDATE_TIME = 30000;
}

//颜色配置
class AppColors {
  static const Color COLOR_THEME = MaterialColor(
    _themePrimaryValue,
    <int, Color>{
      50: Color(_themePrimaryValue),
      100: Color(_themePrimaryValue),
      200: Color(_themePrimaryValue),
      300: Color(_themePrimaryValue),
      400: Color(_themePrimaryValue),
      500: Color(_themePrimaryValue),
      600: Color(_themePrimaryValue),
      700: Color(_themePrimaryValue),
      800: Color(_themePrimaryValue),
      900: Color(_themePrimaryValue),
    },
  );
  static const int _themePrimaryValue = 0xff3c8fff; //主题色

  static const Color COLOR_CCC = Color(0xffcccccc);
  static const Color COLOR_FFF = Color(0xffffffff);
  static const Color COLOR_E8E8E8 = Color(0xffe8e8e8);
  static const Color COLOR_F2F2F2 = Color(0xfff2f2f2);
  static const Color COLOR_4D4D4D = Color(0xff4d4d4d);
  static const Color COLOR_333 = Color(0xff333333);
  static const Color COLOR_666 = Color(0xff666666);
  static const Color COLOR_999 = Color(0xff999999);
  static const Color COLOR_000 = Color(0xff000000);
  static const Color COLOR_TRANSPARENT = Color(0x01000000);

  static const Color COLOR_69A5FF = Color(0xff69a5ff);
  static const Color COLOR_FF796E = Color(0xffff796e);
  static const Color COLOR_FF6053 = Color(0xffff6053);
  static const Color COLOR_FFB94B = Color(0xffffb94b);
  static const Color COLOR_FFAD2C = Color(0xffffad2c);
  static const Color COLOR_51B64A = Color(0xff51b64a);
  static const Color COLOR_7FDA7C = Color(0xff7fda7c);

  static const List<Color> ANIMATED_COLORS = <Color>[
    AppColors.COLOR_FF6053,
    AppColors.COLOR_THEME,
    AppColors.COLOR_FFAD2C,
    AppColors.COLOR_7FDA7C,
    AppColors.COLOR_FF6053,
  ];

  static const Gradient GRADIENT_BUS = LinearGradient(
    colors: [COLOR_51B64A, COLOR_69A5FF],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppImages {
  static const String ICON = 'icon.png';
  static const String PLACEHOLDER = 'icon_placeholder.png';
  static const String SPLASH = 'icon_splash.png';
  static const String BUS = 'icon_bus.png';
  static const String BUS_CROSS = 'icon_bus_1.png';
  static const String BUS_HALF = 'icon_bus_half.png';
  static const String DIRECTION = 'icon_direction.png';
  static const String LINE = 'icon_line.png';
  static const String STATION = 'icon_station.png';
  static const String MAIN_BG = 'icon_main_bg.png';
  static const String ORBITAL = 'icon_orbital.png';
  static const String STATION_BOARD = 'icon_station_board.png';
  static const String BUS_BG = 'icon_house.png';
}
