import 'package:redux/redux.dart';
import '../bean/user_bean.dart';
// 用户reducer

///通过 flutter_redux 的 combineReducers，创建 Reducer<State>
final UserReducer = combineReducers<UserBean>([
  ///将Action，处理Action动作的方法，State绑定
  TypedReducer<UserBean, RefreshUserAction>(_refresh),
]);

///定义处理 Action 行为的方法，返回新的 State
UserBean _refresh(UserBean userInfo, action) {
  userInfo = action.userInfo;
  return userInfo;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshUserAction {
  final UserBean userInfo;
  RefreshUserAction(this.userInfo);
}