import 'package:fapp/src/api/douban.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  TextEditingController _controller = new TextEditingController();
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    loadData("");
    _controller = new TextEditingController.fromValue(TextEditingValue(text: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("书库"),
      ),
      body: Column(
        children: [
          Container(
            width: 1080,
            height: 48,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(color: const Color(0xffefefef), borderRadius: BorderRadius.circular(24)),
            child: TextField(
              controller: _controller,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(16) //限制长度
              ],
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                  size: 24.0,
                ),
                hintText: '请输入书名或作者',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                //内容提交(按回车)的回调
                print('submit $text');
                loadData(text);
              },
            ),
          ),
          Expanded(child: ListView.builder(itemCount: books.length, itemExtent: 200, itemBuilder: showItem))
        ],
      ),
    );
  }

  void loadData(String key) async {
    if (key == "") return;

    Map<String, dynamic> param = {"q": key, "fields": "id,title"};

    var resp = await getBookList("/v2/book/search", param);

    setState(() {
      books = resp['books'];
    });
  }

  Widget showItem(BuildContext context, int index) {
    dynamic item = books[index];
    String desc = "${item['author'][0]} / ${item['pubdate']} / ${item['publisher']}";

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Stack(
        children: [
          Image.network(
            item['image'],
            height: 120,
            fit: BoxFit.fill,
          ),
          Positioned(
              left: 95,
              width: 240,
              height: 120,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Color(0xffebebeb)),
                child: Text(
                  item['summary'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                ),
              )),
          Positioned(
            top: 130,
            child: Text(
              item['title'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            top: 160,
            child: Text(
              desc,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Positioned(
              left: 296,
              top: 135,
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Color(0xFFFFFF00), width: 0.5)),
                child: Column(
                  children: [Icon(Icons.favorite,color: Colors.yellow,), Text("想读",style: TextStyle(color: Colors.grey),)],
                ),
              ))
        ],
      ),
    );
  }
}
