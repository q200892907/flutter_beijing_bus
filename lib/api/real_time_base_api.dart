import '../include.dart';
import '../utils/api_util.dart';
import 'dart:io';

//普通接口基类
abstract class RealTimeBaseApi<D> extends SimpleApi<D> {
  final BuildContext context;

  RealTimeBaseApi(this.context);

  @override
  String onUrl(Map<String, dynamic> params) => AppConfigs.getHttpApiUrl() + apiMethod(params);

  @protected
  String apiMethod(Map<String, dynamic> params);

  @override
  void onFillParams(Map<String, dynamic> data, Map<String, dynamic> params) {
    if (params != null) {
      data.addAll(params);
    }
  }

  @override
  bool onResponseResult(response) {
    return response['root']['status'] == '200' || response['root']['status'] == 200;
  }

  @override
  String onRequestFailedMessage(response, HttpData<D> data) {
    return response['root']['message'];
  }

  @override
  String onRequestSuccessMessage(response, HttpData<D> data) {
    return response['root']['message'];
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
//    options.contentType = ContentType.binary;
  }
}
