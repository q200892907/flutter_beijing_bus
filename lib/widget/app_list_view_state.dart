import '../include.dart';

class AppListViewUtil {
  static Config headerConfig = RefreshConfig(
    visibleRange: 80,
    completeDuration: 0,
    triggerDistance: 80,
  );

  static Config footerConfig = RefreshConfig(
    visibleRange: 0,
    triggerDistance: 20,
    completeDuration: 1000,
  );

  static AppRefreshView refreshView({
    @required BuildContext context,
    @required int refreshStatus,
  }) {
    return AppRefreshView(
      refreshStatus: refreshStatus,
    );
  }

  static AppLoadMoreView loadMoreView({
    @required BuildContext context,
    @required int loadMoreStatus,
    GestureTapCallback onErrorPressed,
  }) {
    return AppLoadMoreView(
      loadMoreStatus: loadMoreStatus,
      loadingText: AppStrings.getLocale(context).loading,
      readyLoadText: AppStrings.getLocale(context).pushToLoad,
      releaseLoadText: AppStrings.getLocale(context).releaseToLoad,
      endText: AppStrings.getLocale(context).noMore,
      errorText: AppStrings.getLocale(context).loadError,
      onErrorPressed: onErrorPressed,
    );
  }

  static JvtdEmptyView emptyView({
    @required BuildContext context,
    @required EmptyStatus emptyStatus,
    GestureTapCallback onErrorPressed,
  }) {
    return JvtdEmptyView(
      loadingColor: AppColors.COLOR_THEME,
      emptyStatus: emptyStatus,
      errorText: AppStrings.getLocale(context).loadErrorClickRetry,
      emptyText: AppStrings.getLocale(context).noDataYet,
      isList: true,
      onErrorPressed: onErrorPressed,
      iconName: AppImages.ICON,
      emptyImgName: AppImages.ICON,
    );
  }
}

abstract class AppListViewState<M, T extends StatefulWidget> extends BaseListViewState<M, T> {
  @override
  BaseEmptyView buildEmptyView() {
    return AppListViewUtil.emptyView(
      context: context,
      emptyStatus: emptyStatus,
      onErrorPressed: () {
        onRefresh();
      },
    );
  }

  @override
  BaseRefreshView buildLoadMoreView(BuildContext context, int loadMoreStatus) {
    return AppListViewUtil.loadMoreView(
        context: context,
        loadMoreStatus: loadMoreStatus,
        onErrorPressed: () {
          loadMore();
        });
  }

  @override
  BaseRefreshView buildRefreshView(BuildContext context, int refreshStatus) {
    return AppListViewUtil.refreshView(
      context: context,
      refreshStatus: refreshStatus,
    );
  }

  @override
  Config footerConfig() {
    return AppListViewUtil.footerConfig;
  }

  @override
  Config headerConfig() {
    return AppListViewUtil.headerConfig;
  }

  @override
  List<Widget> footerWidgets() {
    return null;
  }

  @override
  List<Widget> headerWidgets() {
    return null;
  }

  @override
  Future loadMore() {
    return null;
  }

  @override
  Future onRefresh() {
    return null;
  }
}
