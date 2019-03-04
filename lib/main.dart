import 'include.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// 创建Store，引用 AppState 中的 appReducer 创建 Reducer
  /// initialState 初始化 State
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(
        userInfo: UserBean(),
        themeData: new ThemeData(
          primarySwatch: AppColors.COLOR_THEME,
        ),
        locale: Locale(Strings.ZH, Strings.CH)),
  );

  @override
  Widget build(BuildContext context) {
    //全局路由初始化
    final router = new Router();
    configureRoutes(router, AppRoutes());
    Application.router = router;
    //全局eventBus初始化
    Application.eventBus = EventBus();

    SqliteUtil.instance;

    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder: (context, store) {
        return MaterialApp(
          ///多语言实现代理
          localizationsDelegates: [
            AppStringLocalizedDelegate.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: store.state.locale,
          theme: store.state.themeData,
          supportedLocales: [store.state.locale],
          onGenerateRoute: Application.router.generator,
        );
      }),
    );
  }
}
