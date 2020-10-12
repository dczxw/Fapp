import 'package:fapp/src/base/DbBaseBean.dart';

class ImageBean extends DbBaseBean {
  String id;
  String img;
  int favs;

  @override
  DbBaseBean fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.img = map['img'];
    this.favs = map['favs'];
    return this;
  }

  @override
  String getTableName() {
    return "Image";
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['favs'] = this.favs;
    return data;
  }
}
