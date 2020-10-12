import 'package:fapp/src/db/DbUtils.dart';
import 'package:fapp/src/db/beans/ImageBean.dart';
import 'package:fapp/src/utils/AppUtils.dart';
import 'package:fapp/src/utils/DioUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageDetailPage extends StatefulWidget {
  String id;
  String url;
  String favs;

  ImageDetailPage({Key key, this.id, this.url, this.favs}) : super(key: key);

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
        decoration: BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            Image.network(
              url,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 30,
              left: ScreenUtil().setWidth(540) - 60,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 36,
                  decoration: BoxDecoration(color: Color.fromARGB(128, 0, 0, 0), borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Text(
                    "设为壁纸",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                onTap: setWallPaper,
              ),
            ),
            Positioned(
              right: 10,
              top: ScreenUtil().setHeight(960) - 60,
              child: Container(
                alignment: Alignment.center,
                width: 36,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration:
                        BoxDecoration(color: Color.fromARGB(64, 0, 0, 0), borderRadius: BorderRadius.all(Radius.circular(18))),
                        child: Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        var response = await DioUtil.dio.download(widget.url, "aaa.png");
                      },
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      margin: EdgeInsets.only(top: 10),
                      decoration:
                      BoxDecoration(color: Color.fromARGB(64, 0, 0, 0), borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: EdgeInsets.only(top: 10),
                        decoration:
                        BoxDecoration(color: Color.fromARGB(64, 0, 0, 0), borderRadius: BorderRadius.all(Radius.circular(18))),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await DbUtils.getInstance().openDB("suiper");
                        ImageBean bean = new ImageBean();
                        bean.id = widget.id;
                        bean.img = widget.url;
                        bean.favs = 3223;
                        await DbUtils.getInstance().insertItem(bean);
                        AppUtils.init().toast("收藏成功，请前往个人收藏查看！");
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setWallPaper() async {
    List<ImageBean> list = await DbUtils.getInstance().queryItems(new ImageBean());
    print(list.length);


    var progressString = Wallpaper.ImageDownloadProgress(widget.url);
    progressString.listen((data) {
      print("DataReceived: " + data);
    }, onDone: () async {
      String home = await Wallpaper.homeScreen();
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }
}
