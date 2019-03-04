import '../include.dart';

abstract class AppBottomNavigationBarPageState<T extends StatefulWidget> extends BaseBottomNavigationBarPageState<T, AppState> {
  @override
  double get iconSize => 24;

  @override
  Color unSelectedColor() {
    return AppColors.COLOR_999;
  }

  @override
  Color selectedColor() {
    return AppColors.COLOR_THEME;
  }

  @override
  Widget buildEmptyView(BuildContext context) {
    return null;
  }
}
