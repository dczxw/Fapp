import 'package:fapp/src/api/imageApi.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List _list = new List();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    int len = (_list.length/2).truncate();
    return ListView.builder(
        itemCount: len, itemExtent: 120, itemBuilder: showItem);
  }

  void loadData() async{
    var res = await getImageType("/v1/vertical/category");
    setState(() {
      _list = res['res']['category'];
    });
  }

  Widget showItem(BuildContext context, int index) {
    var item0 = _list[index*2];
    var rname = item0['rname'];
    var cover = item0['cover'];
    var id = item0['id'];

    var item1 = _list[index*2+1];
    var rname1 = item1['rname'];
    var cover1 = item1['cover'];
    var id1 = item1['id'];
    return Container(
      width: ScreenUtil().setWidth(1080),
      child: Row(
        children: [
          Container(
            width: ScreenUtil().setWidth(500),
            margin: EdgeInsets.fromLTRB(10,10,0,10),
            decoration: BoxDecoration(
                image:DecorationImage(
                  image: NetworkImage(cover),
                  fit: BoxFit.fill,
                )
            ),
            child:GestureDetector(
              child:  Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(128, 0, 0,0),
                ),
                child: Text(rname,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              onTap: (){
                Map<String,dynamic> map = {
                  "id":id,
                  "title":rname
                };
                Routes.jump(context, "/imageList",params: map);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10,10,0,10),
            width: ScreenUtil().setWidth(500),
            decoration: BoxDecoration(
                image:DecorationImage(
                  image: NetworkImage(cover1),
                  fit: BoxFit.fill,
                )
            ),
            child:GestureDetector(
              child:  Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(128, 0, 0,0),
                ),
                child: Text(rname1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              onTap: (){
                Map<String,dynamic> map = {
                  "id":id1,
                  "title":rname1
                };
                Routes.jump(context, "/imageList",params: map);
              },
            ),
          )
        ],
      ),
    );
  }

  void onTapItem(PointerDownEvent event) {

  }
}
