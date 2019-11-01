
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/common/model/gank_item.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatefulWidget {
  final GankItem gankItem;

  WebViewPage(this.gankItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {

  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.gankItem.desc),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: _favorite ? Colors.red : Colors.white),
            onPressed: () async {
              if (_favorite) {
                setState(() {
                  _favorite = false;
                });
              } else {
                setState(() {
                  _favorite = true;
                });
              }
            },
          ),
          IconButton(
              icon: Icon(Icons.language),
              onPressed: () async {
                if (await canLaunch(widget.gankItem.url)) {
                  launch(widget.gankItem.url);
                }
              })
        ],
      ),
      withLocalStorage: true,
      url: widget.gankItem.url,
      withJavascript: true,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void dispose() async {
    super.dispose();
  }

}