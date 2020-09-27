import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDetailPage extends StatefulWidget {

  String id;
  String url;

  ImageDetailPage({Key key, this.id,this.url}) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    return Scaffold(
      appBar: null,
      body: Container(
        width: ScreenUtil().setWidth(1080),
        height: ScreenUtil().setWidth(1920),
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Image.network(url,fit: BoxFit.fill,),
      ),
    );
  }
}
