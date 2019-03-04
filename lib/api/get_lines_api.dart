import '../include.dart';
import 'base_api.dart';
import '../bean/line_bean.dart';
export '../bean/line_bean.dart';

class GetLinesApi extends BaseApi<List<LineBean>> {
  GetLinesApi(BuildContext context) : super(context);

  @override
  String apiMethod(Map<String, dynamic> params) {
    return "/ssgj/v1.0.0/checkUpdate?version=1";
  }

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic> onHeaders(Map<String, dynamic> params) {
    String pid = '5';
    //todo 参数目前写死
    int time = 1539706356;
    String cid = '18d31a75a568b1e9fab8e410d398f981';
    String platform = "ios";
    String token = '31d7dae1d869a172f3b66fa14fe274d1';
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
  List<LineBean> onExtractResult(resultData, HttpData<List<LineBean>> data) {
    List resultList = resultData;
    return resultList.map((item) {
      LineBean lineBean = LineBean.fromJson(item);
      lineBean.init();
      return lineBean;
    }).toList();
  }

  @override
  List<LineBean> onResponseSuccess(response, HttpData<List<LineBean>> data) {
    if (response['lines'] == null) {
//      //todo 测试数据
//      LineBean lineBean = LineBean.fromJson({
//        'id': '1230',
//        'linename': '533(北京商学院-天通苑北)',
//        'classify': '1-999路',
//        'status': '1',
//        'version': '1.0.0',
//      });
//      LineBean lineBean1 = LineBean.fromJson({
//        'id': '1231',
//        'linename': '533(天通苑北-北京商学院)',
//        'classify': '1-999路',
//        'status': '1',
//        'version': '1.0.0',
//      });
//      LineBean lineBean2 = LineBean.fromJson({
//        'id': '1232',
//        'linename': '430(东沙各庄-天通苑北)',
//        'classify': '1-999路',
//        'status': '1',
//        'version': '1.0.0',
//      });
//      LineBean lineBean3 = LineBean.fromJson({
//        'id': '1233',
//        'linename': '430(天通苑北-东沙各庄)',
//        'classify':'1-999路',
//        'status': '1',
//        'version': '1.0.0',
//      });
//      lineBean.init();
//      lineBean1.init();
//      lineBean2.init();
//      lineBean3.init();
//      return [
//        lineBean,
//        lineBean1,
//        lineBean2,
//        lineBean3,
//      ];
      return [];
    }
    return response['lines']['line'] == null ? [] : onExtractResult(response['lines']['line'], data);
  }
}
