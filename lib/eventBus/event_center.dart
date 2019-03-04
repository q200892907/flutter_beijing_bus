import '../bean/collect_bus_bean.dart';
/// 全局通知
//登录成功通知
class LoginSuccessEvent {
  bool isPop;
  LoginSuccessEvent({this.isPop = true});
}

//通知刷新收藏列表
class CollectBusListUpdateEvent{
  CollectBusListUpdateEvent();
}

//通知收藏有改变
class CollectBusUpdateEvent{
  CollectBusBean bus;
  bool isAdd;
  CollectBusUpdateEvent(this.bus,[this.isAdd = false]);
}
