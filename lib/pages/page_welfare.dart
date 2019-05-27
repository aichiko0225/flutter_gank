import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 妹子
class WelfarePage extends StatefulWidget {
  static const String ROUTER_NAME = 'WelfarePage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelfarePageState();
  }
}


class _WelfarePageState extends State<WelfarePage> {

  bool _isLoading = true;
  int _page = 1;
  List _gankItems = [];
  bool isOneColumn = true;
  // RefreshController _refreshController;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Row(children: <Widget>[
            Text('111'),
            Text('222'),
            Text('333'),
          ],)
        ],
      ),
    );
  }

  void _getCategoryData() {

  }
  
}
