import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  String endpoint;

  Dio dio;

  ApiService({
    @required this.endpoint,
  }) {
    print('ApiService: constructor: $endpoint');
    dio = Dio();
    dio.interceptors.add(LogInterceptor());
  }

  Future<Response> loadPost() => dio.get('$endpoint/posts').then(
        (response) {
          if (response.statusCode / 100 == 2) {
            return response;
          } else {
            throw ('Error ${response.statusCode}');
          }
        },
      );

  Future<Response> getUserById(int id) =>
      dio.get('$endpoint/users', queryParameters: {'id': id}).then((response) {
        if (response.statusCode / 100 == 2) {
          return response;
        } else {
          throw ('Error ${response.statusCode}');
        }
      });

  // test download json
  // https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json
  // https://support.oneskyapp.com/hc/en-us/article_attachments/202761727/example_2.json
  Future<Response> downloadJson(String saveFilePath) {
    CancelToken cancelToken = CancelToken();
    return dio.download(
      'https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json',
      saveFilePath,
      onReceiveProgress: (received, total) {
        print(
            'downloadJson: progress: ${(received / total * 100).toStringAsFixed(0)}%');
      },
      cancelToken: cancelToken,
    );
  }
}
