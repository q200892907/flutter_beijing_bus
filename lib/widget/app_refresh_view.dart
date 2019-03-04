import '../include.dart';

//加载更多布局样式
class AppRefreshView extends BaseRefreshView {
  final int refreshStatus;

  AppRefreshView({
    @required this.refreshStatus,
  });

  @override
  int getStatus() {
    return refreshStatus;
  }

  @override
  Widget buildEnd(BuildContext context) {
    return buildStatusView(context);
  }

  @override
  Widget buildError(BuildContext context) {
    return buildStatusView(context);
  }

  @override
  Widget buildReadyLoad(BuildContext context) {
    return buildStatusView(context);
  }

  @override
  Widget buildLoading(BuildContext context) {
    return buildStatusView(context);
  }

  @override
  Widget buildReleaseLoad(BuildContext context) {
    return buildStatusView(context);
  }

  Widget buildStatusView(BuildContext context) {
    return RefreshProgressIndicator();
  }
}
