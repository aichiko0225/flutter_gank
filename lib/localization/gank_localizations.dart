import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'locale/locale_base.dart';
import 'locale/locale_en.dart';
import 'locale/locale_zh.dart';

class GankLocalizations {
  final Locale locale;
  GankLocalizations({this.locale});
  
  static Map<String, StringBase> _localizedValues = {
    'en': StringEn(),
    'zh': StringZh(),
  };

  StringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  static GankLocalizations of(BuildContext context) {
    return Localizations.of(context, GankLocalizations);
  }
}

class GankLocalizationsDelegate
    extends LocalizationsDelegate<GankLocalizations> {
  ///全局静态的代理
  static GankLocalizationsDelegate delegate = GankLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<GankLocalizations> load(Locale locale) {
    return SynchronousFuture<GankLocalizations>(GankLocalizations(locale: locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GankLocalizations> old) {
    return false;
  }

}

class GankLocalizationsWrapper extends StatefulWidget {
  final Widget child;

  GankLocalizationsWrapper({Key key, this.child}) : super(key: key);

  @override
  _GankLocalizationsWrapperState createState() => _GankLocalizationsWrapperState();
}

class _GankLocalizationsWrapperState extends State<GankLocalizationsWrapper> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }
}
