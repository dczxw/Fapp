import 'package:dio/dio.dart';
import 'package:fapp/src/utils/DioUtil.dart';

const base_url = "http://service.picasso.adesk.com";

Future<dynamic> getImageType(String url) async {
  Map<String, dynamic> param = {
    "limit": 30,
    "skip": 0,
    "adult": false,
    "first": 1,
    "order": "hot"
  };
  url = base_url + url;
  return await DioUtil.get(url, param);
}

Future<dynamic> getImageList(String url, int limit) async {
  Map<String, dynamic> param = {
    "limit": limit * 16,
    "skip": (limit - 1) * 16,
    "adult": false,
    "first": 1,
    "order": "hot"
  };

  url = base_url + url;
  return await DioUtil.get(url, param);
}
