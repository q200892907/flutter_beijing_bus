import '../include.dart';

class AppTabBar {
  static TabBar custom({@required List<Widget> tabs, TabController controller, bool isScrollable = false, ValueChanged<int> onTap}) {
    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      tabs: tabs,
      labelColor: AppColors.COLOR_FFF,
      unselectedLabelColor: AppColors.COLOR_FFF,
      labelStyle: TextStyle(fontSize: 14),
      unselectedLabelStyle: TextStyle(fontSize: 13),
      indicatorColor: AppColors.COLOR_FFF,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(left: 20, right: 20),
      onTap: onTap,
    );
  }
}
