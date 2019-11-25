import 'package:flutter/foundation.dart';
import 'package:post_app/model/user/user_model.dart';
import 'package:post_app/service/api/api_service.dart';
import 'package:post_app/service/database/database_service.dart';
import 'package:post_app/service/shared_preference/shared_preference_service.dart';

class UserRepo {
  ApiService apiService;
  DatabaseService databaseService;
  SharedPreferenceService prefService;

  UserRepo({
    @required this.apiService,
    @required this.databaseService,
    @required this.prefService,
  });

  Future<UserModel> getUserById(int id) {
    return getUserByIdApi(id).then((user) {
      print('getUserByIdApi: success');
      saveUserCache(user);
      return user;
    }, onError: (e) {
      print('getUserByIdApi: error - $e');
      return getUserByIdCache(id);
    });
  }

  Future<UserModel> getUserByIdApi(int id) {
    return apiService.getUserById(id).then((user) {
      return UserModel.fromJson(user.data[0]);
    });
  }

  Future<UserModel> getUserByIdCache(int id) {
    return databaseService.getUserById(id).then((dbData) {
      print('getUserByIdCache: success - ${dbData.length}');
      if (dbData.length != 0) {
        return UserModel.fromJson(dbData[0]);
      } else {
        throw ('There is no user with id: $id in database');
      }
    });
  }

  Future<bool> saveUserCache(UserModel user) {
    return databaseService.insertUser(user).then((dbData) {
      print('saveUserCache: insert db success - $dbData');
      return true;
    }, onError: (e) {
      print('saveUserCache: insert db error - $e');
      return false;
    });
  }

  // change language pref
  Future<bool> changeLanguage(String lang) => prefService.setCurrentLanguage(lang);
}
