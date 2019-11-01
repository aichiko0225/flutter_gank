import 'package:dio/dio.dart';
import 'package:flutter_gank/config/gank_config.dart';

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (GankConfig.DEBUG) {
      print("请求url: =>${options.path}");
      if (options.data != null) {
        print('请求参数: =>' + options.data.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if (GankConfig.DEBUG) {
      if (response != null) {
        print('返回结果: =>' + response.toString());
      }
    }
    return response;
  }

  @override
  onError(DioError err) {
    if (GankConfig.DEBUG) {
      print('请求异常: =>' + err.toString());
      print('请求异常信息: =>' + err.response?.toString() ?? "");
    }
    return err;
  }
}
