import 'package:flutter/material.dart';
import 'package:post_app/repo/user/user_repo.dart';
import 'package:post_app/service/api/api_service.dart';
import 'package:post_app/service/language/language_service.dart';
import 'package:post_app/service/shared_preference/shared_preference_service.dart';
import 'package:post_app/ui/main_page/main_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'repo/post/post_repo.dart';
import 'service/database/database_service.dart';

const String endpoint = 'https://jsonplaceholder.typicode.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseService databaseService = DatabaseService();

  ApiService apiService = ApiService(endpoint: endpoint);

  await databaseService.setupBd();

  SharedPreferenceService prefService;

  SharedPreferences pref = await SharedPreferences.getInstance();

  prefService = SharedPreferenceService(pref: pref);

  runApp(MyApp(
    databaseService: databaseService,
    apiService: apiService,
    prefService: prefService,
  ));
}

class MyApp extends StatefulWidget {
  final DatabaseService databaseService;
  final ApiService apiService;
  final SharedPreferenceService prefService;

  MyApp({
    @required this.databaseService,
    @required this.apiService,
    @required this.prefService,
  });

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('MyAppState: initState');
  }

  @override
  void dispose() {
    print('MyAppState: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>.value(
          value: widget.databaseService,
        ),
        Provider<ApiService>.value(
          value: widget.apiService,
        ),
        Provider<SharedPreferenceService>.value(
          value: widget.prefService,
        ),
        ProxyProvider<SharedPreferenceService, LanguageService>(
          update: (context, sharedPreferenceService, languageService) =>
              LanguageService(prefService: sharedPreferenceService),
          dispose: (context, languageService) => languageService.dispose(),
        ),
        ProxyProvider2<ApiService, DatabaseService, PostRepo>(
          update: (context, apiService, databaseService, postRepo) => PostRepo(
            apiService: apiService,
            databaseService: databaseService,
          ),
        ),
        ProxyProvider3<ApiService, DatabaseService, SharedPreferenceService,
            UserRepo>(
          update: (context, apiService, databaseService,
                  sharedPreferenceService, userRepo) =>
              UserRepo(
            apiService: apiService,
            databaseService: databaseService,
            prefService: sharedPreferenceService,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Post App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: mainRoute,
      ),
    );
  }
}
