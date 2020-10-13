import 'dart:convert';
import 'package:fapp/src/api/info.dart';
import 'package:fapp/src/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List dataList = new List();
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var response = await getNews(page);
    var data = response.data;
     data = json.decode(data.substring(22, data.length - 1));
    setState(() {
      dataList = data['data']['newsstream'];
    });
  }

  Widget buildContent() {
    if (dataList.length > 0) {
      return ListView.builder(
          itemCount: 10,
          itemExtent: 100,
          itemBuilder: (BuildContext context, int index) {
            return createItem(index, dataList[index]);
          });
    }
    return CupertinoActivityIndicator(animating: true, radius: 22);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Center(
        child: buildContent(),
      ),
      onRefresh: _onRefresh,
    );
  }

  Future<Null> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget createItem(int index, dynamic obj) {
    print(obj);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(obj['title'],
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(""),
                  Text("${obj["source"]} ${obj['newsTime']}")
                ],
              ),
            ),
            Image.network(obj['thumbnails']['image'][0]['url'])
          ],
        ),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xffe9e9e9)))),
      ),
      onTap: () {
        AppUtils.init().toast(obj['title']);
      },
    );
  }
}
