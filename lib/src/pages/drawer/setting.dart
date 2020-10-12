import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<ServiceItemViewModel> serviceList = [
    ServiceItemViewModel(
      title: '我的壁纸',
      icon: Icon(
        Icons.image,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的新闻',
      icon: Icon(
        Icons.gamepad,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的视频',
      icon: Icon(
        Icons.video_library,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的博客',
      icon: Icon(
        Icons.track_changes,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的相册',
      icon: Icon(
        Icons.monochrome_photos,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的书籍',
      icon: Icon(
        Icons.book,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的句子',
      icon: Icon(
        Icons.language,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
    ServiceItemViewModel(
      title: '我的诗词',
      icon: Icon(
        Icons.nature_people,
        size: 25,
        color: Colors.lightBlue,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
      ),
      body: Container(
        child: GridView(
          padding: EdgeInsets.symmetric(vertical: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: serviceList.map((item) => ServiceItem(item)).toList(),
        ),
      ),
    );
  }

  Widget ServiceItem(ServiceItemViewModel data) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: <Widget>[
          Expanded(child: data.icon),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItemViewModel {
  /// 图标
  final Icon icon;

  /// 标题
  final String title;

  const ServiceItemViewModel({
    this.icon,
    this.title,
  });
}
