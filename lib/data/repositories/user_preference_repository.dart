import 'package:post_app/service/shared_preference/shared_preference_service.dart';

class UserReferenceRepository {
  SharedPreferenceService service;
  UserReferenceRepository(this.service);

  Future<bool> setCurrentLanguage(String lang) => service.setCurrentLanguage(lang);
  String getCurrentLanguage() => service.getCurrentLanguage();
}