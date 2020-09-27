import 'dart:io';

import 'package:fapp/src/utils/AppUtils.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:fapp/src/utils/SpUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  Map<String, dynamic> param;

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  bool _lights = SpUtil.preferences.getBool("isSave");

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle dark = SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(dark);
    }

    if(SpUtil.preferences.getString("username")!=null){
      _controller = new TextEditingController.fromValue(
          TextEditingValue(text: SpUtil.preferences.getString("username")));
    }
    if(SpUtil.preferences.getString("password")!=null){
      _controller2 = new TextEditingController.fromValue(
          TextEditingValue(text: SpUtil.preferences.getString("password")));
    }

    if(_lights == null){
      setState(() {
        _lights = false;
      });
    }

    return WillPopScope(
      child: Scaffold(
          body: new SingleChildScrollView(
        child: Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil().setHeight(1920),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 72),
                child: Text(
                  "墨   语",
                  style: TextStyle(
                      inherit: true,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(64)),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(1920),
                height: ScreenUtil().setHeight(144),
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(72.0), // 圆角边框
                ),
                child: TextField(
                  controller: _controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(16) //限制长度
                  ],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black87,
                      size: 24.0,
                    ),
                    hintText: '请输入用户名',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(1920),
                height: ScreenUtil().setHeight(144),
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(72.0), // 圆角边框
                ),
                child: TextField(
                  controller: _controller2,
                  obscureText: true,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(16) //限制长度
                  ],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.https,
                      color: Colors.black87,
                      size: 24.0,
                    ),
                    hintText: '请输入密码',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(960),
                height: ScreenUtil().setHeight(96),
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Switch(
                      value: _lights,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.blue,
                      onChanged: (bool value) {
                        SpUtil.preferences.setBool("isSave", value);
                        setState(() {
                          _lights = value;
                        });
                      },
                    ),
                    Text("记住密码")
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(1920),
                height: ScreenUtil().setHeight(144),
                margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(72.0), // 圆角边框
                ),
                child: FlatButton(
                    color: Colors.black87,
                    onPressed: () => this.login(context),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(72.0)),
                    child: Text(
                      "登     录",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(48),
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      )),
      onWillPop: () async {
        SystemNavigator.pop();
      },
    );
  }

  void login(BuildContext context) {
    var username = _controller.text;
    var password = _controller2.text;

    if (username == "") {
      AppUtils.init().toast("请输入用户名");
      return;
    }

    if (password == "") {
      AppUtils.init().toast("请输入密码");
      return;
    }

    if (password.length < 6) {
      AppUtils.init().toast("请输入大于6位数的密码");
      return;
    }

    if (username == "admin" && password == '123789') {
      AppUtils.init().toast("登录成功");
      setInt("isLogin", 1);
      Routes.jump(context, Routes.homePage);
      if (_lights) {
        SpUtil.preferences.setString("username", username);
        SpUtil.preferences.setString("password", password);
      } else {
        SpUtil.preferences.setString("username", "");
        SpUtil.preferences.setString("password", "");
      }
    } else {
      AppUtils.init().toast("用户名或密码错误");
      return;
    }
  }
}
