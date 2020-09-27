import 'package:fapp/src/api/imageApi.dart';
import 'package:fapp/src/utils/DioUtil.dart';
import 'package:fapp/src/utils/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return ListView.builder(
        itemCount: _list.length, itemExtent: 208, itemBuilder: showItem);
  }

  void loadData() async{
    var res = await getImageType("/v1/vertical/category");
    setState(() {
      _list = res['res']['category'];
    });
  }

  Widget showItem(BuildContext context, int index) {
    var item = _list[index];
    print(item);
    var rname = item['rname'];
    var cover = item['cover'];
    var id = item['id'];
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
    );
  }

  void onTapItem(PointerDownEvent event) {

  }
}
