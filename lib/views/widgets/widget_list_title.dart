import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/common/constant/colors.dart';

class GankItemTitle extends StatefulWidget {

  final String category;

  GankItemTitle(this.category);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GankItemTitleState();
  }
}

class GankItemTitleState extends State<GankItemTitle> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: AppColors.COLOR_TITLE_BG,
        border: Border(
          bottom: BorderSide(width: 0.0, color: Theme.of(context).dividerColor)
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 22),
            width: 4,
            height: 20,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.category,
              style: Theme.of(context).textTheme.title,
            ),
          )
        ],
      ),
    );
  }
}