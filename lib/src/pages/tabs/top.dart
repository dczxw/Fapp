import 'package:fapp/src/pages/home/hot_today_item.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView(
          padding: EdgeInsets.symmetric(vertical: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: serviceList.map((item) => ServiceItem(item, context)).toList(),
        ),
      ),
    );
  }

  Widget ServiceItem(ViewModelItem data, BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              margin: EdgeInsets.only(bottom: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data.icon),
              ),
            ),
            Text(
              data.title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Map<String, dynamic> param = {
          "title": data.title,
          "icon": data.icon,
          "url": data.url,
        };
        Routes.jump(context, "/hotDetail", params: param);
      },
    );
  }
}
