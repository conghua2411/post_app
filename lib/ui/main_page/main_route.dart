import 'package:post_app/repo/post/post_repo.dart';
import 'package:provider/provider.dart';

import 'main_bloc.dart';
import 'main_page.dart';

var mainRoute = ProxyProvider<PostRepo, MainBloc>(
  initialBuilder: (context) {
    MainBloc mainBloc = MainBloc(
        postRepo: Provider.of<PostRepo>(context, listen: false));
    mainBloc.loadPostListData();
    mainBloc.downloadJson();
    return mainBloc;
  },
  builder: (context, postRepo, mainBloc) => mainBloc,
  dispose: (context, mainBloc) => mainBloc.dispose(),
  child: MainPage(),
);