import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/service/api/api_service.dart';
import 'package:post_app/service/database/database_service.dart';

class PostRepo {
  ApiService apiService;
  DatabaseService databaseService;

  PostRepo({
    @required this.apiService,
    @required this.databaseService,
  }) {
    print('PostRepo: constructor');
  }

  Future<List<PostModel>> loadPost() => loadPostApi().then((list) {
        saveListPostCache(list);
        return list;
      }, onError: (e) {
        print('load api error : $e');
        return loadPostCached();
      });

  Future<List<PostModel>> loadPostApi() =>
      apiService.loadPost().then((response) {
        List<PostModel> list = (response.data as List)
            .map((postResponse) => PostModel.fromJson(postResponse))
            .toList();
        return list;
      });

  Future<List<PostModel>> loadPostCached() =>
      databaseService.loadAllPost().then((listPost) =>
          listPost.map((post) => PostModel.fromJson(post)).toList());

  Future<bool> saveListPostCache(List<PostModel> list) {
    return databaseService.insertListPost(list).then((dbData) {
      print('databaseService: insert db success $dbData');
      return true;
    }, onError: (e) {
      print('databaseService: insert db error $e');
      return false;
    });
  }

  // test jsom download
  Future<Response> downloadJson(String saveFilePath) => apiService.downloadJson(saveFilePath);
}
