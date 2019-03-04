//环境配置
//环境枚举类
enum Environment {
  DEVELOPMENT, //开发
  TEST, //测试
  PRODUCTION, //生产
}

//banner状态
class BannerStatus {
  static const String SHOW = '1'; //显示
  static const String NOT_SHOW = '2'; //不显示
}

//banner位置
class BannerType {
  static const String HOME = '1'; //位置
  static const String PROJECT = '2'; //项目
  static const String PROJECT_ROLL = '3'; //项目滚动
}

//公告状态
class NoticeStatus {
  static const String ONLINE = '1'; //线上
  static const String OFFLINE = '2'; //下线
}
