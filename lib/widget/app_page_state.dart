import '../include.dart';

abstract class AppPageState<T extends StatefulWidget> extends BasePageState<T, AppState> {
  @override
  Color get appBarColor => AppColors.COLOR_THEME;

  @override
  TextStyle get appBarTextStyle => TextStyle(color: AppColors.COLOR_FFF, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget buildEmptyView(BuildContext context) {
    return JvtdEmptyView(
      emptyStatus: emptyStatus,
      errorText: AppStrings.getLocale(context).loadErrorClickRetry,
      emptyText: AppStrings.getLocale(context).noDataYet,
      isList: true,
      onErrorPressed: emptyErrorPressed,
      loadingColor: AppColors.COLOR_THEME,
      iconName: AppImages.ICON,
      emptyImgName: AppImages.ICON,
    );
  }

  @override
  String exitAppTips() {
    return AppStrings.getLocale(context).exitApp;
  }
}
