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
    print("请求url -- ${url} \n 参数 --- ${arguments}");
    var response = await HttpClient.dio.get(url, queryParameters: arguments);
    print("响应数据 --- ${response.data}");
    return response;
  }

  static String replacePicUrl(String picApi) {
    var pic = HttpClient.domin + picApi;
    return pic.replaceAll("\\", "/");
  }
}
