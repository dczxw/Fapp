import 'package:dio/dio.dart';

class DioUtil {
  static Dio dio = new Dio();

  static Future<dynamic> postJson(String url, Object param) async {
    var options = Options(headers: {
      "content-type": "application/json",
    });

    print("url==" + url);
    var res = await Dio().post(url, data: param, options: options);
    print(res);

    return res.data;
  }

  static Future<dynamic> get(String url, Map<String, dynamic> param) async {
    var options = Options(headers: {
      "content-type": "application/json",
    });

    print("url==" + url);
    var res = await Dio().get(url, queryParameters: param, options: options);
    print(res);

    return res.data;
  }
}
