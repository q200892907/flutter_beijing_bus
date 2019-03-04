import '../include.dart';

//加载更多布局样式
class AppLoadMoreView extends BaseRefreshView {
  final int loadMoreStatus;
  final String endText;
  final String errorText;
  final String loadingText;
  final String readyLoadText;
  final String releaseLoadText;
  final TextStyle textStyle;
  final GestureTapCallback onErrorPressed;

  AppLoadMoreView({
    @required this.loadMoreStatus,
    this.endText,
    this.errorText,
    this.loadingText,
    this.readyLoadText,
    this.releaseLoadText,
    this.textStyle = const TextStyle(color: Colors.grey, fontSize: 14),
    this.onErrorPressed,
  });

  @override
  int getStatus() {
    return loadMoreStatus;
  }

  @override
  Widget buildEnd(BuildContext context) {
    return Text(
      endText,
      style: textStyle,
    );
  }

  @override
  Widget buildError(BuildContext context) {
    return GestureDetector(
      onTap: onErrorPressed,
      child: Text(
        errorText,
        style: textStyle,
      ),
    );
  }

  @override
  Widget buildReadyLoad(BuildContext context) {
    return Text(
      readyLoadText,
      style: textStyle,
    );
  }

  @override
  Widget buildLoading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          loadingText,
          style: textStyle,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(width: 24, height: 24),
            child: SpinKitCircle(
              color: textStyle.color,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildReleaseLoad(BuildContext context) {
    return Text(
      releaseLoadText,
      style: textStyle,
    );
  }
}
