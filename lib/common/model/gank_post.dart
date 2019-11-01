import 'package:flutter_gank/common/model/gank_item.dart';

class GankPost {
  List<String> category;
  Map itemDataMap = Map();
  String girlImage;
  List<GankItem> gankItems = [];

  GankPost.fromJson(Map<String, dynamic> json)
      : category =
            json['category']?.map<String>((c) => c.toString())?.toList() {
    var results = json['results'];
    results.forEach((name, value) {
      if (name != '福利') {
        itemDataMap[name] = _createGankItemListFromJson(name, value);
      }
    });
    girlImage = json['results']['福利'][0]['url'];
  }

  List<GankItem> _createGankItemListFromJson(String name, List value) {
    var gankItemList = value
        .map<GankItem>((item) => GankItem.fromJson(item, category: name))
        .toList();
    gankItems.add(GankItem.title(true, name));
    gankItems.addAll(gankItemList);
    return gankItemList;
  }
}
