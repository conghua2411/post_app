import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_app/base/base_bloc.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:post_app/repo/post/post_repo.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloc {
  PostRepo postRepo;

  BehaviorSubject<List<PostModel>> bsListPost =
      BehaviorSubject<List<PostModel>>();

  MainBloc({
    @required this.postRepo,
  }) {
    print('MainBloc: constructor');
  }

  loadPostListData() {
    print('loadPostListData');
    postRepo.loadPost().then((data) {
      print('loadPostListData: load success : ${data.length}');
      bsListPost.add(data);
    }, onError: (e) {
      print('loadPostListData: load error : $e');
    });
  }

  @override
  void dispose() {
    print('MainBloc: dispose');
    bsListPost.close();
  }

  /// for testing server json language
  readFile() {
    getApplicationDocumentsDirectory().then((directory) {
      print('getApplicationDocumentsDirectory: success - ${directory.path}');
      String saveFilePath = '${directory.path}/en.json';
      File file = File(saveFilePath);

      String strData = file.readAsStringSync();

      Map<String, dynamic> mapData = jsonDecode(strData);

      print('readFile: success - map $mapData}');
    }, onError: (e) {
      print('getApplicationDocumentsDirectory: error - $e');

    });
  }

  downloadJson() {
    getApplicationDocumentsDirectory().then((directory) {
      print('getApplicationDocumentsDirectory: success - ${directory.path}');

      String saveFilePath = '${directory.path}/en.json';

      File file = File(saveFilePath);

      if (file.existsSync()) {
        file.deleteSync();
        file = File(saveFilePath);
      }

      print('time: ${DateTime.now().toIso8601String()}');
      postRepo.downloadJson(saveFilePath).then((response) {
        print('time: ${DateTime.now().toIso8601String()}');
        print('downloadJson: success - ${response.data}');

        File file = File(saveFilePath);

        String strData = file.readAsStringSync();

        Map<String, dynamic> mapData = jsonDecode(strData);

        print('downloadJson: success - map $mapData}');

      }, onError: (e) {
        print('downloadJson: error - $e');
      });
    }, onError: (e) {
      print('getApplicationDocumentsDirectory: error - $e');
    });
  }
}
