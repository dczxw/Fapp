import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseState<T extends StatefulWidget> extends State {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  void initState() {
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
    super.initState();
  }
}
