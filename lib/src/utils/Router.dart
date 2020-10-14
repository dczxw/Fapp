import 'package:fapp/src/pages/drawer/message.dart';
import 'package:fapp/src/pages/drawer/setting.dart';
import 'package:fapp/src/pages/home.dart';
import 'package:fapp/src/pages/home/HotDetail.dart';
import 'package:fapp/src/pages/home/WebViewPage.dart';
import 'package:fapp/src/pages/images/imageDetail.dart';
import 'package:fapp/src/pages/images/imageList.dart';
import 'package:fapp/src/pages/login/login.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart'hide Router;

var routeMap = {
  "/login": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  }),
  "/home": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  }),
  "/message": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MessagePage();
  }),
  "/setting": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SettingPage();
  }),
  "/imageList": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String typeId = params['id'].first;
    String typeName = params['title'].first;
    return ImageListPage(typeId: typeId, typeName: typeName);
  }),
  "/imageDetail": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String img = params['img'].first;
    String id = params['id'].first;
    String favs = params['favs'].first;
    return ImageDetailPage(url: img, id: id, favs: favs);
  }),
  "/hotDetail": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String title = params['title'].first;
    String icon = params['icon'].first;
    String url = params['url'].first;
    return HotDetail(url: url, icon: icon, title: title);
  }),
  "/webview": Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String url = params['url'].first;
    return WebViewPage(url: url);
  }),
};

class Routes {
  static Router router = new Router();

  //配置类
  static String root = '/'; //根目录
  static String loginPage = '/login'; //登录
  static String homePage = '/home'; //首页页面
  static String messagePage = '/message'; //消息
  static String settingPage = '/setting'; //设置页面

  //静态方法
  static void configureRoutes() {
    //路由配置
    //找不到路由
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });

    //整体配置

    routeMap.forEach((key, value) {
      router.define(key, handler: value);
    });
  }

  static Future jump(BuildContext context, String path,
      {Map<String, dynamic> params, TransitionType transition = TransitionType.inFromRight }) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');
    path = path + query;

    return router.navigateTo(context, path, transition: transition);
  }
}
