import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gank/api/gank_api.dart';
import 'package:flutter_gank/common/model/gank_item.dart';
import 'package:flutter_gank/common/model/gank_post.dart';
import 'package:flutter_gank/views/widgets/widget_list_item.dart';
import 'package:flutter_gank/views/widgets/widget_list_title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class NewPage extends StatefulWidget {
  static const String ROUTER_NAME = 'NewPage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewPageState();
  }
}

class NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin {

  String _girlImage;
  String _date;
  List<GankItem> _gankItems;
  RefreshController _refreshController;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event) {
//      if (mounted) {
//        _date = event.date;
//        getNewData(date: _date);
//      }
//    });
    _refreshController = new RefreshController();
    getNewData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Stack(
      children: <Widget>[
        ///content view
        Offstage(
          offstage: _isLoading ? true : false,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onOffsetChange: null,
            controller: _refreshController,
            child: _buildListView(),
          ),
        ),
        Offstage(
          offstage: _isLoading ? false : true,
          child: Center(child: CupertinoActivityIndicator()),
        )
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildImageBanner(context);
          } else {
            var gankItem = _gankItems[index - 1];
            return gankItem.isTitle ? GankItemTitle(gankItem.category) : GankListItem(gankItem);
          }
      },
    );
  }
  GestureDetector _buildImageBanner(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: CachedNetworkImage(
        height: 200,
        imageUrl: _girlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Future getNewData({String date, bool isRefresh = false}) async {
    _date = date;
    var todayJson;
    if (date == null) {
      todayJson = await GankApi.getTodayData();
    } else {
      todayJson = await GankApi.getSpecialDayData(_date);
    }
    var todayItem = GankPost.fromJson(todayJson);
    setState(() {
      if (mounted) {
        _gankItems = todayItem.gankItems;
        _girlImage = todayItem.girlImage;
        _isLoading = false;
      }
    });
    if (isRefresh) {
      _refreshController.refreshCompleted();
    }
  }

  Future _onRefresh() async {
    getNewData(date: _date, isRefresh: true);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}