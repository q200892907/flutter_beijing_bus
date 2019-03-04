import '../include.dart';
import '../utils/api_util.dart';
import 'dart:io';

final String phoneId = Random.secure().nextInt(10000000).toString();

//普通接口基类
abstract class BaseApi<D> extends SimpleApi<D> {
  final BuildContext context;

  BaseApi(this.context);

  @override
  String onUrl(Map<String, dynamic> params) => AppConfigs.getHttpApiUrl() + apiMethod(params);

  @protected
  String apiMethod(Map<String, dynamic> params);

  @override
  Map<String, dynamic> onHeaders(Map<String, dynamic> params) {
    String pid = '5';
    int time = DateUtil.nowTimestamp() ~/ 1000;
    String cid = '67a88ec31de7a589a2344cc5d0469074';
    String platform = Platform.isIOS ? "ios" : "android";
    String token = ApiUtil.token('bjjw_jtcx', platform, cid, time, apiMethod(params));
    return {
      "VID": '6',
      "PID": pid,
      "TIME": time.toString(),
      "CID": cid,
      "PLATFORM": platform,
      "CTYPE": "json",
      "IMEI": phoneId,
      "ABTOKEN": token,
    };
  }

  @override
  void onFillParams(Map<String, dynamic> data, Map<String, dynamic> params) {
    if (params != null) {
      data.addAll(params);
    }
  }

  @override
  bool onResponseResult(response) {
    return response['errcode'] == '200' || response['errcode'] == 200;
  }

  @override
  String onRequestFailedMessage(response, HttpData<D> data) {
    return response['errmsg'];
  }

  @override
  String onRequestSuccessMessage(response, HttpData<D> data) {
    return response['errmsg'];
  }

  @override
  String onParamsError(Map<String, dynamic> params) {
    return context != null ? AppStrings.getLocale(context).apiParameterError : '接口参数错误';
  }

  @override
  String onParseFailed(HttpData<D> data) {
    return context != null ? AppStrings.getLocale(context).dataParsingFailed : '数据解析失败';
  }

  @override
  String onNetworkError(HttpData<D> data) {
    return context != null ? AppStrings.getLocale(context).noNetwork : '暂无网络连接，请链接网络后重试';
  }

  @override
  String onNetworkRequestFailed(HttpData<D> data) {
    return context != null ? AppStrings.getLocale(context).networkError : '网络异常，请稍后重试';
  }

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  void onConfigOptions(Options options, Map<String, dynamic> params) {
//    options.contentType = ContentType.json;
  }
}
