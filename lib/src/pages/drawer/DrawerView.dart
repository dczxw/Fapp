import 'package:fapp/src/base/BaseState.dart';
import 'package:fapp/src/config/provide.dart';
import 'package:fapp/src/config/theme.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:fapp/src/utils/SpUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends BaseState<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white24),
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://siuper.oss-cn-hangzhou.aliyuncs.com/dz/images/blog/2439ec30f87526bb.jpg'),
                  fit: BoxFit.cover),
            ),
            accountName: Text(
              "admin",
              style: TextStyle(fontSize: 24),
            ),
            accountEmail: Text(
              "475891508@qq.com",
              style: TextStyle(fontSize: 16),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: ListTile(
              leading: Icon(
                Icons.message,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                '消息',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onTap: (){Routes.jump(context, "/message");},
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).accentColor,
                ),
                title: Text('主题',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    )),
                onTap: () => {onTheme(context)},
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
                title: Text('我的',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    )),
                onTap: () => {onSetting(context)},
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).accentColor,
              ),
              title: Text('注销',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                  )),
              onTap: () => {onLogout(context)},
            ),
          ),
        ],
      ),
    );
  }

  onSetting(BuildContext context) {
    Routes.jump(context, "/setting");
  }

  onTheme(BuildContext context) {
    showDialog<Null>(
        context: context,
        builder: (BuildContext c) {
          return SimpleDialog(
            title: const Text('请选择主题:'),
            children: [
              buildOption("dark", context),
              buildOption("blue", context),
              buildOption("light", context),
              buildOption("red", context),
            ],
          );
        });
  }

  setTheme(String name) {
    SpUtil.preferences.setString("theme", name);
    Provide.value<ConfigProvide>(context).$getTheme();
  }

  onLogout(BuildContext context) {
    SpUtil.preferences.setInt("isLogin", 0);
    Routes.jump(context, Routes.loginPage);
  }

  buildOption(String name, BuildContext context) {
    String curr = SpUtil.preferences.getString("theme");
    return SimpleDialogOption(
      onPressed: () {
        setTheme(name);
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 40),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Text(materialColor[name]['name'],
                  style: TextStyle(
                      color: Color(materialColor[name]['primaryColor']),
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
            Expanded(
              child: Checkbox(
                  value: name == curr,
                  activeColor: Color(materialColor[name]['primaryColor']),
                  onChanged: (bool value) {
                    setTheme(name);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
