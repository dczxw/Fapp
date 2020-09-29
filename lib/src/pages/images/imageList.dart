import 'package:fapp/src/api/imageApi.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageListPage extends StatefulWidget {
  String typeId;
  String typeName;

  ImageListPage({Key key, this.typeId, this.typeName}) : super(key: key);

  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List list = new List();
  int page = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    loadData();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels) == _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
    super.initState();
  }

  Future<void> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      setState(() {
        page = 1;
      });
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.typeName),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
              itemExtent: 300,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: (list.length / 2).round(),
              itemBuilder: showItem),
        ),
      ),
    );
  }

  void loadData() async {
    var res = await getImageList("/v1/vertical/category/${widget.typeId}/vertical", page);
    var newList = res['res']['vertical'];
    if (page == 1) {
      list.clear();
    }
    setState(() {
      list.addAll(newList);
    });
  }

  Widget showItem(BuildContext context, int index) {
    index = index * 2;
    var item0 = list[index];
    var item1 = list[index + 1];
    String src0 = item0['img'];
    String src1 = item1['img'];
    String num0 = formatNum(item0['favs']).toString();
    String num1 = formatNum(item1['favs']).toString();
    return Row(
      children: [
        GestureDetector(
          child: Container(
            alignment: Alignment.bottomRight,
            width: ScreenUtil().setWidth(480),
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), image: DecorationImage(image: NetworkImage(src0))),
            child: Container(
              width: 45,
              height: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color.fromARGB(128, 0, 0, 0), borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 13,
                  ),
                  Text(" "),
                  Text(
                    num0,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            toImageDetail(item0);
          },
        ),
        Container(
          width: ScreenUtil().setWidth(30),
        ),
        GestureDetector(
          child: Container(
            alignment: Alignment.bottomRight,
            width: ScreenUtil().setWidth(480),
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), image: DecorationImage(image: NetworkImage(src1))),
            child: Container(
              width: 45,
              height: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color.fromARGB(128, 0, 0, 0), borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 13,
                  ),
                  Text(" "),
                  Text(
                    num1,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            toImageDetail(item1);
          },
        ),
      ],
    );
  }

// 格式化喜欢数量
  String formatNum(int num) {
    if (num > 1000 * 1000) {
      return (num / 1000 / 1000).toStringAsFixed(1) + "m";
    } else if (num > 100) {
      return (num / 1000).toStringAsFixed(1) + "k";
    } else {
      return num.toString();
    }
  }

  void toImageDetail(item) {
    Map<String, dynamic> param = {
      "img": item["img"],
      "id": item["id"],
    };

    Routes.jump(context, "/imageDetail", params: param);
  }

  void _onLoadMore() {
    setState(() {
      page += 1;
    });
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
