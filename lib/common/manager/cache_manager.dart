//import 'dart:convert';
//import 'dart:io';
//
//import 'package:flutter_gank/common/constant/strings.dart';
//import 'package:objectdb/objectdb.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//
//class CacheManager {
//  static ObjectDB db;
//  static const List<String> IGNORE_URL_LIST = [
//    'github.com',
//    'gank.io/api/search/query',
//    'gank.io/api/add2gank'
//  ];
//
//  static bool ignoreUrl(String url) {
//    for (String ignore in IGNORE_URL_LIST) {
//      if (url.indexOf(ignore) > 0) {
//        return true;
//      }
//    }
//    return false;
//  }
//
//  static init() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path =
//        join(documentsDirectory.path, "${AppStrings.STRING_DB_CACHE}");
//    db = ObjectDB(path);
//    await db.open();
//  }
//
//  static set(CacheObject cacheObject) async {
//    if (ignoreUrl(cacheObject.url)) return;
//    cacheObject.time = DateTime.now().millisecondsSinceEpoch;
//    var cachedObjectList = await db.find({'url': cacheObject.url});
//    if (cachedObjectList != null && cachedObjectList.length > 0) {
//      await db.update({
//        'url': cachedObjectList[0]['url']
//      }, {
//        'value': json.encode(cacheObject.value),
//        'time': cacheObject.time,
//      });
//    } else {
//      await db.insert(cacheObject.toJson());
//    }
//  }
//
//  static get(String url) async {
//    var cachedObjectList = await db.find({'url': url});
//    if (cachedObjectList != null && cachedObjectList.length > 0) {
//      return json.decode(cachedObjectList[0]['value']);
//    }
//  }
//
//  static clearCaches() async {
//    await db.remove({});
//  }
//}
//
//class CacheObject {
//  String url;
//  dynamic value;
//  int time;
//
//  CacheObject({this.url, this.value, this.time});
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['url'] = this.url;
//    data['value'] = json.encode(this.value);
//    data['time'] = this.time;
//    return data;
//  }
//}
