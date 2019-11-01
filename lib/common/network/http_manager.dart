import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gank/common/constant/strings.dart';
import 'package:flutter_gank/common/manager/cache_manager.dart';
import 'package:flutter_gank/common/network/http_code.dart';
import 'package:flutter_gank/common/network/http_response.dart';
import 'package:flutter_gank/config/gank_config.dart';
import 'http_log_interceptor.dart';

enum HttpMethod { get, post, patch, put, delete, options }

class HttpManager {
  Dio dio;

  static HttpManager get instance => _getInstance();
  static HttpManager _instance;

  HttpManager._init() {
    if (dio == null) {
      dio = Dio();
      dio.interceptors.add(HttpLogInterceptor());
    }
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = new HttpManager._init();
    }
    return _instance;
  }

  String getHttpMethod(HttpMethod httpMethod) {
    String method;
    if (httpMethod == HttpMethod.get) {
      method = 'get';
    } else if (httpMethod == HttpMethod.post) {
      method = 'post';
    } else if (httpMethod == HttpMethod.patch) {
      method = 'patch';
    } else if (httpMethod == HttpMethod.put) {
      method = 'put';
    } else if (httpMethod == HttpMethod.delete) {
      method = 'delete';
    } else if (httpMethod == HttpMethod.options) {
      method = 'options';
    } else {
      method = 'get';
    }
    return method;
  }

  Future<HttpResponse> request(url,
      {method = HttpMethod.get, params, header}) async {
    ///Headers
    Map<String, String> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    ///Options
    Options option = new Options();
    option.headers = headers;
    option.method = getHttpMethod(method);
    option.connectTimeout = GankConfig.CONNECT_TIMEOUT;
    option.receiveTimeout = GankConfig.RECEIVE_TIMEOUT;

    /// 暂时先去掉缓存机制，还没有时间了解


    ///Caches
//    var cacheData = await CacheManager.get(url);
//    var connectivityResult = await (Connectivity().checkConnectivity());

    ///no network
//    if (connectivityResult == ConnectivityResult.none) {
//      if (cacheData != null && !CacheManager.ignoreUrl(url)) {
//        if (GankConfig.DEBUG) {
//          print('[缓存]请求url: =>' + url);
//          print('[缓存]返回结果: =>' + cacheData.toString());
//        }
//        return HttpResponse(cacheData, true, Code.SUCCESS);
//      } else {
//        return HttpResponse(
//            AppStrings.NETWORK_CONNECT_ERROR, false, Code.NETWORK_ERROR);
//      }
//    }
    Response response;

    ///dio request
    try {
      response = await dio.request(url, data: params, options: option);
//      await CacheManager.set(CacheObject(url: url, value: response.data));
    } on DioError catch (e) {
//      if (cacheData != null && !CacheManager.ignoreUrl(url)) {
//        return HttpResponse(cacheData, true, Code.SUCCESS);
//      }
      Response errorResponse = e.response ?? Response();
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return HttpResponse(e.message, false, errorResponse.statusCode);
    }

    ///result
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpResponse(response.data, true, Code.SUCCESS);
      }
    } catch (e) {
      return HttpResponse(e.toString(), false, response.statusCode);
    }

    return HttpResponse(AppStrings.UNKNOWN_ERROR, false, response.statusCode);
  }
}
