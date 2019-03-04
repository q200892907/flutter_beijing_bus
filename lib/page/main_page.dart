import '../include.dart';
import 'dart:ui';
import 'real_time_page.dart';
import 'change_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends AppPageState<MainPage> with SingleTickerProviderStateMixin {
  @override
  bool get isDoubleClick => true;

  double _tabHeight = 40;
  List<String> _tabTitles;
  TabController _controller;

  @override
  void initData(BuildContext context) {
    super.initData(context);
    _tabTitles = <String>[
      AppStrings.getLocale(context).realTimeQuery,
//      AppStrings.getLocale(context).changeToTheQuery,
    ];
    _controller = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 375 / 200,
          child: JvtdImage.local(name: AppImages.MAIN_BG),
        ),
        Column(
          children: <Widget>[
            _buildAppBar(context),
            _buildTabBar(),
            _buildTabBarView(),
          ],
        )
      ],
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: SafeArea(
        top: false,
        child: TabBarView(
          children: <Widget>[
            RealTimePage(),
//            ChangePage(),
          ],
          controller: _controller,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        constraints: BoxConstraints.expand(height: kTextTabBarHeight),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16),
              child: JvtdImage.local(name: AppImages.ICON, color: AppColors.COLOR_FFF, fit: BoxFit.contain, width: 20, height: 20),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.getLocale(context).appName,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.COLOR_FFF, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(left: 16),
              child: IconButton(
                onPressed: () {
                  Application.router.navigateTo(context, AppRoutes.COLLECT_ROUTE_NAME).then((data) {
                    Application.eventBus.fire(CollectBusListUpdateEvent());
                  });
                },
                icon: Icon(
                  Icons.star,
                  color: AppColors.COLOR_FFF,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      constraints: BoxConstraints.expand(height: _tabHeight),
      child: AppTabBar.custom(
        tabs: _tabTitles.map((title) {
          return Tab(
            text: title,
          );
        }).toList(),
        controller: _controller,
      ),
    );
  }
}
