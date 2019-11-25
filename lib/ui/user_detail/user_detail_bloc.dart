import 'package:flutter/foundation.dart';
import 'package:post_app/repo/user/user_repo.dart';
import 'package:rxdart/rxdart.dart';

enum UserDetailViewState {loading, loaded, error}

class UserDetailBloc {
  UserRepo userRepo;

  BehaviorSubject<String> bsImageBackground = BehaviorSubject();
  BehaviorSubject<String> bsImageUser = BehaviorSubject();
  BehaviorSubject<String> bsUsername = BehaviorSubject();
  BehaviorSubject<String> bsEmail = BehaviorSubject();
  BehaviorSubject<String> bsPhone = BehaviorSubject();
  BehaviorSubject<String> bsWebsite = BehaviorSubject();

  BehaviorSubject<UserDetailViewState> bsUserDetailState = BehaviorSubject();
  BehaviorSubject<String> bsStateMessage = BehaviorSubject();

  UserDetailBloc({
    @required this.userRepo,
  });

  dispose() {
    bsImageBackground.close();
    bsImageUser.close();
    bsUsername.close();
    bsEmail.close();
    bsPhone.close();
    bsWebsite.close();

    bsUserDetailState.close();
    bsStateMessage.close();
  }

  getUserById(int id) {
    print('getUserById');
    userRepo.getUserById(id).then((user) {
      print('getUserById success');
      bsUsername.add(user.name);
      bsImageBackground.add('https://picsum.photos/id/${user.id * 123}/300/300');
      bsImageUser.add('https://picsum.photos/id/${user.id * 111}/300/300');
      bsEmail.add(user.email);
      bsPhone.add(user.phone);
      bsWebsite.add(user.website);

      bsUserDetailState.add(UserDetailViewState.loaded);
    }, onError: (e) {
      print('getUserById: error - $e');
      bsStateMessage.add('getUserById: error - $e');
      bsUserDetailState.add(UserDetailViewState.error);
    });
  }

  Future<bool> changeLanguage(String lang) => userRepo.changeLanguage(lang);
}
