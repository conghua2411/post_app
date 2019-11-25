import 'package:post_app/repo/post/post_repo.dart';
import 'package:post_app/service/api/api_service.dart';
import 'package:post_app/service/database/database_service.dart';

void main() async {

  DatabaseService databaseService = DatabaseService();

  await databaseService.setupBd();

  String endpoint = 'https://jsonplaceholder.typicode.com';

  var postRepo = PostRepo(apiService: ApiService(endpoint: endpoint), databaseService: databaseService);

}