import 'package:flutter/material.dart';
import 'package:flutter_gank/pages/page_category.dart';
import 'package:flutter_gank/pages/page_favorite.dart';
import 'package:flutter_gank/pages/page_home.dart';
import 'package:flutter_gank/pages/page_new.dart';
import 'package:flutter_gank/pages/page_welfare.dart';
import 'package:flutter_gank/redux/app_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'localization/gank_localizations.dart';

void main() => runApp(GankApp());

class GankApp extends StatelessWidget {
  /// 初始化 State
  final store = Store<AppState>(
    appReducer,
    ///初始化数据
    initialState: AppState(
      themeData: ThemeData(
        primaryColor: Colors.blue,
        platform: TargetPlatform.android,
      ),
      locale: Locale('zh', 'CH'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GankLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            title: 'Gank App',
            theme: store.state.themeData,
            routes: {
              HomePage.ROUTER_NAME: (context) => GankLocalizationsWrapper(child: HomePage()) ,
              CategoryPage.ROUTER_NAME: (context) => CategoryPage(),
              FavoritePage.ROUTER_NAME: (context) => FavoritePage(),
              WelfarePage.ROUTER_NAME: (context) => WelfarePage(),
              NewPage.ROUTER_NAME: (context) => NewPage(),
            },
            home: HomePage(),
          );
        },
      ),
    );
  }
}
