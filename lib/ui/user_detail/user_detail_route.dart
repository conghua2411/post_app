import 'package:post_app/repo/user/user_repo.dart';
import 'package:post_app/ui/user_detail/user_detail_bloc.dart';
import 'package:post_app/ui/user_detail/user_detail_page.dart';
import 'package:provider/provider.dart';

getUserDetailRoute(int userId) {
  return ProxyProvider<UserRepo, UserDetailBloc>(
    create: (context) {
      UserDetailBloc userDetailBloc = UserDetailBloc(
        userRepo: Provider.of<UserRepo>(
          context,
          listen: false,
        ),
      );
      userDetailBloc.getUserById(userId);
      return userDetailBloc;
    },
    update: (context, userRepo, userDetailBloc) => userDetailBloc,
    dispose: (context, userDetailBloc) => userDetailBloc.dispose(),
    child: UserDetailPage(),
  );
}