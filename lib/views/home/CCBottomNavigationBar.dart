import 'package:flutter/material.dart';

class CCBottomNavigationBar extends StatefulWidget {

  final PageController pageController;
  final ValueChanged<int> onTap;

  CCBottomNavigationBar(this.pageController, this.onTap);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomNavigationBarState();
  }
}


class _BottomNavigationBarState extends State<CCBottomNavigationBar> {

  var currentIndex = 0;

  List<BottomNavigationBarItem> _bottomTabs() {
    return <BottomNavigationBarItem>[
      ///最新
      BottomNavigationBarItem(
        icon: Icon(IconData(0xe67f, fontFamily: 'IconFont')),
        title: Text('最新'),
      ),

      ///分类
      BottomNavigationBarItem(
        icon: Icon(IconData(0xe603, fontFamily: 'IconFont')),
        title: Text('分类'),
      ),

      ///妹纸
      BottomNavigationBarItem(
        icon: Icon(IconData(0xe637, fontFamily: 'IconFont')),
        title: Text('妹纸'),
      ),

      ///收藏
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text('收藏'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      items: _bottomTabs(),
      type: BottomNavigationBarType.fixed,
      iconSize: 32,
      currentIndex: currentIndex,
      onTap: (index) {
        if (widget.onTap != null) {
          currentIndex = index;
          widget.pageController.jumpToPage(index);
          widget.onTap(index);
        }
      },
    );
  }
  
}