import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiRequest {
  final String url;
  final Map queryParameters;
  var data;

  ApiRequest({
    this.url,
    this.queryParameters,
    this.data,
  });

  static ApiRequest _instance;

  static ApiRequest getInstance(url, query, data) {
    if (_instance == null)
      _instance = ApiRequest(url: url, queryParameters: query, data: data);
    return _instance;
  }

  Dio _dio() {
    print("call _dio object");
    return Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        connectTimeout: 500000,
        receiveTimeout: 500000,
      ),
    );
  }

  post() async {
    try {
      var res = await _dio().post(url, data: data);

      if (res.statusCode == 200) return res;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('catched $e');
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        Get.snackbar("Error", "connectTimeout");
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        Get.snackbar("Error", "unable to connect to the server");
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        Get.snackbar("Error", "Something went wrong");
        return;
      }
      print(e);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }


  Future<void> get() async {
    try {
      var res = await _dio().get(url, queryParameters: queryParameters);

      if (res.statusCode == 200) return res;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('catched');
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        Get.snackbar("Error", "connectTimeout");
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        Get.snackbar("Error", "unable to connect to the server");
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        Get.snackbar("Error", "Something went wrong");
        return;
      }
      print(e);
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
