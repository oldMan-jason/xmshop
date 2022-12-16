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
    print("Get请求url -- ${url} \n 参数 --- ${arguments}");
    var response = await HttpClient.dio.get(url, queryParameters: arguments);
    print("Get响应数据 --- ${response.data}");
    return response;
  }

  Future<Response> post(String api, {Map? data}) async {
    String url = HttpClient.domin + api;
    print("Post请求url -- ${url} \n 参数 --- ${data}");
    var response = await HttpClient.dio.post(url, data: data);
    print("Post响应数据 --- ${response.data}");
    return response;
  }

  static String replacePicUrl(String picApi) {
    var pic = HttpClient.domin + picApi;
    return pic.replaceAll("\\", "/");
  }
}
