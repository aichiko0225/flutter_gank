import 'package:flutter/material.dart';
import 'package:flutter_gank/localization/gank_localizations.dart';
import 'package:flutter_gank/localization/locale/locale_base.dart';

class CommonUtils {
  static StringBase getLocale(BuildContext context) {
    return GankLocalizations.of(context).currentLocalized;
  }
}