import 'dart:math';

import 'package:fapp/src/api/info.dart';
import 'package:fapp/src/pages/home/hot_today_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotDetail extends StatefulWidget {
  String title;
  String url;
  String icon;

  HotDetail({Key key, this.title, this.url, this.icon}) : super(key: key);

  @override
  _HotDetailState createState() => _HotDetailState();
}

class _HotDetailState extends State<HotDetail> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    var response = await getHotDetail(widget.url, "today_hot");
    setState(() {
      dataList = response.data['data'];
      print(dataList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
    );
  }

  Widget buildContent() {
    if (dataList.length > 0) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.title),
            floating: true,
            //设置悬浮样式
            flexibleSpace:
                Image.network(imageList[Random().nextInt(imageList.length)], fit: BoxFit.cover),
            expandedHeight: 180,
            snap: true,
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => buildItem(index, context),
            childCount: dataList.length,
          ))
        ],
      );
    }
    return Center(

      child: CupertinoActivityIndicator(animating: true, radius: 22),
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
          child: Stack(
            children: [
              Positioned(
                child: Text('${index + 1}、', style: TextStyle(fontSize: 18, color: Colors.red)),
                left: 0,
                top: 0,
              ),
              Positioned(
                child: Text(
                  '${dataList[index]['title']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 16),
                ),
                left: 30,
                top: 3,
                right: 35,
              ),
              Positioned(
                child: Text(
                  '${dataList[index]['desc']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 13, color: Colors.blue),
                ),
                left: 30,
                right: 25,
                bottom: 0,
              ),
              Positioned(
                child: Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
                right: 5,
                bottom: 20,
              )
            ],
          ),
        ),
        buildBottom(index)
      ],
    );
  }

  Widget buildBottom(int index) {
    if (index == dataList.length - 1) {
      return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          ") -- 我是有底线的 --（",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
    return Text("");
  }
}
