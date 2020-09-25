import 'dart:io';

import 'package:fapp/src/pages/login/login.dart';
import 'package:fapp/src/utils/SpUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'config/provide.dart';
import 'config/theme.dart';
import 'pages/home.dart';
import 'utils/Router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.configureRoutes();
  realRunApp();
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-"+success.toString());
  runApp(ProviderNode(child: MainApp(), providers: providers));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();

    int isLogin = SpUtil.preferences.getInt("isLogin");

    if (isLogin != 1) {
      return MaterialApp(
        onGenerateRoute: Routes.router.generator,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      );
    }

    return Provide<ConfigProvide>(
      builder: (context, child, configProvide) {
        return MaterialApp(
          onGenerateRoute: Routes.router.generator,
          theme: AppTheme.getThemeData(configProvide.theme),
          home: HomePage(),
        );
      },
    );
  }
}
