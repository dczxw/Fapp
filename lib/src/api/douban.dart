import 'package:fapp/src/utils/DioUtil.dart';

const base_url = "http://t.yushu.im";

Future<dynamic> getBookList(String url,Map<String,dynamic> param) async {
  url = base_url + url;
  return await DioUtil.get(url, param);
}