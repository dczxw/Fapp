import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child:ListView.builder(
            itemCount: 100,
            itemExtent: 100,
            itemBuilder: onItemShow
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {});
  }

  Widget onItemShow(BuildContext context, int index) {
    return Text("ssss");
  }
}
