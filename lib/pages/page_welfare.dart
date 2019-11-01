import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/api/gank_api.dart';
import 'package:flutter_gank/common/constant/strings.dart';
import 'package:flutter_gank/common/model/gank_item.dart';
import 'package:flutter_gank/utils/common_utils.dart';
import 'package:flutter_gank/utils/time_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 妹子
class WelfarePage extends StatefulWidget {
  static const String ROUTER_NAME = 'WelfarePage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelfarePageState();
  }
}


class _WelfarePageState extends State<WelfarePage> with AutomaticKeepAliveClientMixin {

  bool _isLoading = true;
  List _gankItems = [];
  int _page = 1;
  bool isOneColumn = false;
  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController();
    initWelfareData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: _isLoading,
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullUp: true,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isOneColumn ? 1 : 2,
                    childAspectRatio: 2 / (isOneColumn ? 2 : 3),
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: _gankItems?.length ?? 0,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    var gankItem = _gankItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            // ignore: missing_return
                            .push(MaterialPageRoute(builder: (context) {
//                          return GalleryPage(
//                              [gankItem.url.replaceFirst("large", "mw690")],
//                              gankItem.desc);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _buildImageWidget(gankItem),
                      ),
                    );
                  }),
            ),
          ),
          Offstage(
            offstage: !_isLoading,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageWidget(gankItem) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: gankItem.url,
                fit: BoxFit.cover,
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      formatDateStr(gankItem.publishedAt),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future _getCategoryData() async {
    var categoryData = await GankApi.getCategoryData(AppStrings.WELFARE, _page);
    var gankItems = categoryData['results']
        .map<GankItem>((itemJson) => GankItem.fromJson(itemJson,
        category: CommonUtils.getLocale(context).gankWelfare))
        .toList();
    return gankItems;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void initWelfareData() async {
    var gankItems = await _getCategoryData();
    setState(() {
      _gankItems.addAll(gankItems);
      _isLoading = false;
    });
  }

  void _onRefresh() async {
    _page = 1;
    var gankItems = await _getCategoryData();
    _refreshController.refreshCompleted();
    setState(() {
      _gankItems = gankItems;
    });
  }

  void _onLoading() async {
    _page++;
    var gankItems = await _getCategoryData();
    _refreshController.loadComplete();
    setState(() {
      _gankItems.addAll(gankItems);
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  
}
