import '../include.dart';
import 'base_api.dart';
import '../bean/bus_bean.dart';
export '../bean/bus_bean.dart';
export '../bean/get_bus_req_bean.dart';

class GetBusApi extends BaseApi<BusBean> {
  GetBusApi(BuildContext context) : super(context);

  @override
  String apiMethod(Map<String, dynamic> params) {
    return "/ssgj/v1.0.0/update?id="+params['id'];
  }

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic> onHeaders(Map<String, dynamic> params) {
    String pid = '5';
    //todo 参数目前写死
    int time = 1540031093;
    String cid = '18d31a75a568b1e9fab8e410d398f981';
    String platform = "ios";
    String token = '55750cf92a54b09bd52e23105f7f60aa';
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
  BusBean onExtractResult(resultData, HttpData<BusBean> data) {
    List resultList = resultData;
    BusBean bean =BusBean.fromJson(resultList.first);
    bean.decode();
    return bean;
  }

  @override
  BusBean onResponseSuccess(response, HttpData<BusBean> data) {
    return response['busline'] == null ? [] : onExtractResult(response['busline'], data);
  }
}
