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

  // return await DioUtil.dio.get(
  //     "http://shankapi.ifeng.com/shanklist/_/getColumnInfo_seo/_/dynamicFragment/6714844336023928914/1601024220000/20/3-35191-/getColumnInfoCallback?callback=getColumnInfoCallback&_=16010242200001");
}
