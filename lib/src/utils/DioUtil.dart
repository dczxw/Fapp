import 'package:dio/dio.dart';

class DioUtil {
  static Dio dio = new Dio();

  static Future<String> post() async {
    var url = "http://118.24.76.239:9000/blog/list";
    var param = {"blog_status": 1, "token": "c3f5667b63e7e52d9064e69a05c59fd1"};
    var options = Options(headers: {
      "content-type": "application/json",
    });

    print("========0000");
    var res = await Dio().post(url, data: param, options: options);
    print("========1111");
    print(res);

    return res.data;
  }

  static Future<Response<dynamic>> postInfo() async {
    var url =
        "https://apinew.juejin.im/recommend_api/v1/article/recommend_cate_tag_feed";
    var param = {
      "id_type": 2,
      "sort_type": 300,
      "cate_id": "6809637769959178254",
      "tag_id": "6809640445233070094",
      "cursor": "eyJ2IjoiNjg2ODEzODU2OTQwODQ0NjQ3MSIsImkiOjQwfQ==",
      "limit": 20
    };
    var options = Options(headers: {
      "content-type": "application/json",
    });

    Response res = await Dio().post(url, data: param, options: options);

    return res;
  }
}
