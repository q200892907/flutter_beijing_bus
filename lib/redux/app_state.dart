import '../include.dart';
import 'user_reducer.dart';
import '../bean/user_bean.dart';

class AppState extends JvtdState {
  UserBean userInfo; //用户信息

  AppState({
    this.userInfo,
    ThemeData themeData,
    Locale locale,
  }) : super(themeData, locale);
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
AppState appReducer(AppState state, action) {
  return AppState(
    ///通过自定义 UserReducer 将 JvtdState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过自定义 JvtdThemeDataReducer 将 JvtdState 内的 themeData 和 action 关联在一起
    themeData: JvtdThemeDataReducer(state.themeData, action),

    ///通过自定义 JvtdLocaleReducer 将 JvtdState 内的 locale 和 action 关联在一起
    locale: JvtdLocaleReducer(state.locale, action),
  );
}
