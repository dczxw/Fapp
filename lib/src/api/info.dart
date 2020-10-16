import 'package:dio/dio.dart';
import 'package:fapp/src/utils/DioUtil.dart';

Future<Response<dynamic>> getNews(int page) async {
  var now = new DateTime.now().millisecondsSinceEpoch;
  var start = now - 12 * 3600 * 1000;
  var list = [
    "http://shankapi.ifeng.com/shanklist/_/getColumnInfo_seo/_",
    "/dynamicFragment/6714844336023928914/",
    start,
    "/20/3-35191-/getColumnInfoCallback?callback=getColumnInfoCallback&_=",
    "${now}${page}"
  ];

  return await DioUtil.dio.get(list.join());
}

Future<Response<dynamic>> getHotDetail(String url, String type) async {
  String path = "http://api.siuper.cn/t/rss/detail";
  Map<String, dynamic> param = {
    "type": type,
    "url": url,
  };

  return await DioUtil.dio.post(path, data: param);
}
