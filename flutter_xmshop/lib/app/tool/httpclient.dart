import 'package:dio/dio.dart';

// 网络请求库的封账
class HttpClient {
  // 域名
  static String domin = "https://xiaomi.itying.com/";
  // Dio
  static Dio dio = Dio();

  // 配置Dio的相关网络参数配置
  HttpClient() {
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

  // Get方法
  Future<Response> get(String api, {Map<String, dynamic>? arguments}) async {
    String url = HttpClient.domin + api;
    var response = await HttpClient.dio.get(url, queryParameters: arguments);
    return response;
  }

  static String replacePicUrl(String picApi) {
    var pic = HttpClient.domin + picApi;
    return pic.replaceAll("\\", "/");
  }
}
