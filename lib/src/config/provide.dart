import 'package:fapp/src/utils/SpUtil.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';

class ConfigProvide with ChangeNotifier {
  var parentContext; // 接受Provider所传的context
  increment(context) {  // provider的model
    parentContext = context;
    notifyListeners();
  }

// 主题
  String theme = 'light';

  Future $getTheme() async {
    String _theme = await SpUtil.preferences.getString("theme");
    print(_theme);
    if (_theme != null) {
      $setTheme(_theme);
    }
  }

  Future $setTheme(payload) async {
    theme = payload;
    SpUtil.preferences.setString("theme",theme);
    notifyListeners();
  }
}

final providers = Providers()   //将ConfigProvide对象添加进providers
  ..provide(Provider<ConfigProvide>.value(ConfigProvide()));
