import 'package:fapp/src/base/BaseState.dart';
import 'package:fapp/src/pages/drawer/DrawerView.dart';
import 'package:fapp/src/pages/tabs/image.dart';
import 'package:fapp/src/pages/tabs/top.dart';
import 'package:fapp/src/pages/tabs/book.dart';
import 'package:fapp/src/pages/tabs/video.dart';
import 'package:fapp/src/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var arrList = ["首页", "视频", "图片", "书库"];
  String title = "首页";
  int start = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        title = arrList[tabController.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            //创建之前写好的三个页面，万物皆是Widget
            new TopPage(),
            new VideoPage(),
            new ImagePage(),
            new BookPage(),
          ],
        ),
        bottomNavigationBar: Container(
            height: 54,
            child: new Material(
              //底部栏整体的颜色
              color: Theme.of(context).accentColor,
              elevation: 60.0,
              child: new TabBar(
                indicator: const BoxDecoration(),
                controller: tabController,
                tabs: <Tab>[
                  createTab(0, Icons.home),
                  createTab(1, Icons.videocam),
                  createTab(2, Icons.image),
                  createTab(3, Icons.book),
                ],
                //tab被选中时的颜色，设置之后选中的时候，icon和text都会变色
                labelColor: Colors.white,
                //tab未被选中时的颜色，设置之后选中的时候，icon和text都会变色
                unselectedLabelColor: Colors.white60,
              ),
            )),
      ),
      onWillPop: () async {
        var now = DateTime.now().millisecondsSinceEpoch;
        if ((now - start) < 2000) {
          SystemNavigator.pop();
          setState(() {
            start = now;
            count = 0;
          });
        }else{
          AppUtils.init().toast("再按一次退出应用");
          setState(() {
            start = now;
          });
        }

        return false;
      },
    );
  }

  Widget createTab(index, icon) {
    return Tab(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          Text(
            arrList[index],
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    //释放内存，节省开销
    tabController.dispose();
    super.dispose();
  }
}
