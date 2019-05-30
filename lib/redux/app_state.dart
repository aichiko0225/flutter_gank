import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

///全局Redux store 的对象，保存State数据
class AppState {
  ///用户信息
  // User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///构造方法
  AppState({this.themeData, this.locale});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
AppState appReducer(AppState state, action) {
  return AppState(
        themeData: combineThemeDataReducer(state.themeData, action),
        locale: combineLocaleReducer(state.locale, action)
      );
}

Reducer<State> combineReducers<State>(Iterable<Reducer<State>> reducers) {
  return (State state, dynamic action) {
    for (final reducer in reducers) {
      state = reducer(state, action);
    }
    return state;
  };
}

final combineLocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocaleAction>(_localeRefresh),
]);

Locale _localeRefresh(Locale locale, RefreshLocaleAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocaleAction {
  final Locale locale;

  RefreshLocaleAction(this.locale);
}

///通过 flutter_redux 的 combineReducers，实现 Reducer 方法
final combineThemeDataReducer = combineReducers<ThemeData>([
  ///将 Action 、处理 Action 的方法、State 绑定
  TypedReducer<ThemeData, RefreshThemeDataAction>(_themeRefresh),
]);

///定义处理 Action 行为的方法，返回新的 State
ThemeData _themeRefresh(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshThemeDataAction {

  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}



