import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("消息"),
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemExtent: 72,
        itemCount: 10,
        itemBuilder: createItem,
      ),
    );
  }

  Widget createItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg'),
            ),
            padding: EdgeInsets.only(left: 20),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "作品审批",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
                Text("您的作品《春天的故事》已经发布成功",
                  style: TextStyle(fontSize: 16),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
