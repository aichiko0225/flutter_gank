import 'package:flutter/material.dart';
import 'package:flutter_gank/common/event/common_event.dart';
import 'package:flutter_gank/common/manager/app_manager.dart';
import 'package:flutter_gank/pages/page_category.dart';
import 'package:flutter_gank/pages/page_favorite.dart';
import 'package:flutter_gank/pages/page_new.dart';
import 'package:flutter_gank/pages/page_welfare.dart';
import 'package:flutter_gank/views/home/CCBottomNavigationBar.dart';
import 'package:flutter_gank/views/widgets/widget_icon_font.dart';

class HomePage extends StatefulWidget {

  static const String ROUTER_NAME = 'HomePage';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;
  String _currentDate = '今日最新干货';
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _registerEventListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: CCBottomNavigationBar(_pageController, _pageChange),
    );
  }

  ///build main body.
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChange,
          controller: _pageController,
          children: <Widget>[
            NewPage(),
            CategoryPage(),
            WelfarePage(),
            FavoritePage(),
          ],
        )
      ],
    );
  }


  ///注册事件监听器
  void _registerEventListener() {
//    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event) {
//      if (mounted) {
//        setState(() {
//          _currentDate = event.date;
//        });
//      }
//    });
  }
  ///build AppBar.
  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Offstage(
        offstage: _currentPageIndex != 0,
        ///标题栏显示当前日期
        child: Text(_currentDate ?? ''),
      ),
      actions: <Widget>[_buildActions()],
    );
  }

  ///创建标题栏右侧按钮
  IconButton _buildActions() {
    return IconButton(
      icon: Icon(_getActionsIcon(), size: 22, color: Colors.white),
      onPressed: () async {
        if (_currentPageIndex == 0) {
          ///显示/隐藏日期
          // AppManager.notifyShowHistoryDateEvent();
        } else if (_currentPageIndex == 1) {
          ///去搜索页
          // NavigatorUtils.goSearch(context);
        } else if (_currentPageIndex == 2) {
          ///切换妹纸图列数按钮
          // AppManager.eventBus.fire(ChangeWelfareColumnEvent());
        } else {
          // FavoriteManager.syncFavorites(context);
        }
      },
    );
  }
  ///获取标题栏右侧图标.
  IconData _getActionsIcon() {
    if (_currentPageIndex == 0) {
      return IconFont(0xe8a6);
    } else if (_currentPageIndex == 1) {
      return IconFont(0xe783);
    } else if (_currentPageIndex == 2) {
      return IconFont(0xe63a);
    } else {
      return IconFont(0xe619);
    }
  }

  ///页面切换回调
  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}



