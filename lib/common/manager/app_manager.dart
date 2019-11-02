//import 'dart:io';
//
//import 'package:dio/dio.dart';
//import 'package:event_bus/event_bus.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_gank/api/api_gank.dart';
//import 'package:flutter_gank/api/api_github.dart';
//import 'package:flutter_gank/common/constant/strings.dart';
//import 'package:flutter_gank/common/event/event_show_history_date.dart';
//import 'package:flutter_gank/common/manager/cache_manager.dart';
//import 'package:flutter_gank/common/manager/favorite_manager.dart';
//import 'package:flutter_gank/common/manager/user_manager.dart';
//import 'package:flutter_gank/common/model/github_user.dart';
//import 'package:flutter_gank/common/network/http_manager.dart';
//import 'package:flutter_gank/common/utils/common_utils.dart';
//import 'package:flutter_gank/common/utils/sp_utils.dart';
//import 'package:flutter_gank/config/gank_config.dart';
//import 'package:flutter_gank/redux/app_state.dart';
//import 'package:flutter_gank/redux/redux_locale.dart';
//import 'package:flutter_gank/redux/redux_theme.dart';
//import 'package:flutter_gank/redux/redux_user.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:redux/redux.dart';
//import 'package:url_launcher/url_launcher.dart';
//
//import 'package:package_info/package_info.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_gank/redux/app_state.dart';

class AppManager {
  static EventBus eventBus = EventBus();
  static initApp(BuildContext context) async {
    try {


    } catch(e) {

    }
  }

}


//class AppManager {
//  static EventBus eventBus = EventBus();
//
//  static initApp(BuildContext context) async {
//    ///初始化用户信息
//    try {
//      Store<AppState> store = StoreProvider.of(context);
//      User localUser = await UserManager.getUserFromLocalStorage();
//      if (localUser != null) {
//        store.dispatch(UpdateUserAction(localUser));
//      }
//
//      ///读取主题
//      String themeIndex = await SPUtils.get(GankConfig.THEME_COLOR);
//      if (themeIndex != null && themeIndex.isNotEmpty) {
//        await AppManager.switchThemeData(context, int.parse(themeIndex));
//      }
//
//      ///切换语言
//      String localeIndex = await SPUtils.get(GankConfig.LOCALE);
//      if (localeIndex != null && localeIndex.length != 0) {
//        await AppManager.changeLocale(context, int.parse(localeIndex));
//      }
//
//      ///初始化收藏
//      await FavoriteManager.init();
//
//      /// 初始化缓存
//      await CacheManager.init();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  static notifyShowHistoryDateEvent() {
//    AppManager.eventBus.fire(ShowHistoryDateEvent());
//  }
//
//  static ThemeData getThemeData(context) {
//    return StoreProvider.of<AppState>(context).state.themeData;
//  }
//
//  static checkUpdate(context) async {
//    if (Platform.isAndroid) {
//      MethodChannel flutterNativePlugin =
//          MethodChannel(AppStrings.FLUTTER_NATIVE_PLUGIN_CHANNEL_NAME);
//      var hasNewVersion = await flutterNativePlugin.invokeMethod('checkupdate');
//      if (!hasNewVersion) {
//        Fluttertoast.showToast(
//          msg: CommonUtils.getLocale(context).alreadyNewVersion,
//          backgroundColor: Colors.black,
//          gravity: ToastGravity.CENTER,
//          textColor: Colors.white,
//        );
//      }
//    } else if (Platform.isIOS) {
//      var info = await PackageInfo.fromPlatform();
//
//      var data = FormData.from({
//        "appKey": "ab5dce55Ac4bcW408cPb8c2Aaeac179c5f6g",
//        "version": info.version,
//      });
//      var updateResult = await HttpManager.instance.request(
//        GankApi.CHECK_UPDATE,
//        method: HttpMethod.post,
//        params: data,
//      );
//      var hasNewVersion = updateResult.data["update"] == "Yes";
//
//      Fluttertoast.showToast(
//        msg: hasNewVersion
//            ? CommonUtils.getLocale(context).hasNewVersion
//            : CommonUtils.getLocale(context).alreadyNewVersion,
//        backgroundColor: Colors.black,
//        gravity: ToastGravity.CENTER,
//        textColor: Colors.white,
//      );
//    }
//  }
//
//  static starFlutterGank(context) async {
//    User user = StoreProvider.of<AppState>(context).state.userInfo;
//    if (user != null && user.isLogin) {
//      bool success = await GithubApi.starFlutterGank(user.token);
//      if (success) {
//        CommonUtils.showToast(CommonUtils.getLocale(context).starSuccess);
//      } else {
//        CommonUtils.showToast(CommonUtils.getLocale(context).starFailed);
//      }
//    } else {
//      launch(AppStrings.STRING_GANK_SOURCE);
//    }
//  }
//
//  static switchThemeData(context, int index) async {
//    Store store = StoreProvider.of<AppState>(context);
//    ThemeData themeData;
//    List<Color> colors = CommonUtils.getThemeListColor();
//    themeData = new ThemeData(primaryColor: colors[index]);
//    await SPUtils.save(GankConfig.THEME_COLOR, index.toString());
//    store.dispatch(new RefreshThemeDataAction(themeData));
//  }
//
//  static changeLocale(context, int index) async {
//    Store<AppState> store = StoreProvider.of<AppState>(context);
//    Locale locale = store.state.platformLocale;
//    switch (index) {
//      case 0:
//        locale = Locale('zh', 'CH');
//        break;
//      case 1:
//        locale = Locale('en', 'US');
//        break;
//    }
//    store.dispatch(RefreshLocaleAction(locale));
//    await SPUtils.save(GankConfig.LOCALE, index.toString());
//  }
//}
