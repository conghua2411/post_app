import 'package:flutter/material.dart';
import 'package:post_app/base/base_state.dart';
import 'package:post_app/service/language/language_service.dart';
import 'package:post_app/ui/user_detail/user_detail_bloc.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  @override
  State createState() => UserDetailState();
}

class UserDetailState extends BaseState<UserDetailPage> {
  _changeLanguageKr() {
    print('change language kr');
    Provider.of<UserDetailBloc>(context).changeLanguage('kr').then(
            (success) {
          if (success) {
            Provider.of<LanguageService>(context).changeLanguage('kr');
          } else {
            print('UserDetailPage: change language $success');
          }
        }, onError: (e) {
      print('UserDetailPage: change language: error: $e');
    });
  }

  _changeLanguageEn() {
    print('change language en');
    Provider.of<UserDetailBloc>(context).changeLanguage('en').then(
            (success) {
          if (success) {
            Provider.of<LanguageService>(context).changeLanguage('en');
          } else {
            print('UserDetailPage: change language $success');
          }
        }, onError: (e) {
      print('UserDetailPage: change language: error: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<LanguageService>(context).getStringKey('User')),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.amber,
            ),
            onPressed: _changeLanguageKr,
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.red,
            ),
            onPressed: _changeLanguageEn,
          ),
        ],
      ),
      body: StreamBuilder<UserDetailViewState>(
        initialData: UserDetailViewState.loading,
        stream: Provider.of<UserDetailBloc>(context).bsUserDetailState,
        builder: (context, snapshot) {
          if (snapshot.data == UserDetailViewState.loaded) {
            return Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: StreamBuilder<String>(
                          initialData: '',
                          stream:
                              Provider.of<UserDetailBloc>(context).bsUsername,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            );
                          },
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 250,
                            decoration: BoxDecoration(),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: StreamBuilder<String>(
                                initialData: null,
                                stream: Provider.of<UserDetailBloc>(context)
                                    .bsImageBackground,
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.image,
                                        size: 56,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: StreamBuilder<String>(
                                initialData: null,
                                stream: Provider.of<UserDetailBloc>(context)
                                    .bsImageUser,
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://picsum.photos/id/${1 * 111}/300/300',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('Email: '),
                            Expanded(
                              child: StreamBuilder<String>(
                                initialData: '',
                                stream: Provider.of<UserDetailBloc>(context)
                                    .bsEmail,
                                builder: (context, snapshot) {
                                  return Text(snapshot.data);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('Phone: '),
                            Expanded(
                              child: StreamBuilder<String>(
                                initialData: '',
                                stream: Provider.of<UserDetailBloc>(context)
                                    .bsPhone,
                                builder: (context, snapshot) {
                                  return Text(snapshot.data);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('website: '),
                            Expanded(
                              child: StreamBuilder<String>(
                                initialData: '',
                                stream: Provider.of<UserDetailBloc>(context)
                                    .bsWebsite,
                                builder: (context, snapshot) {
                                  return Text(snapshot.data);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            /// loading and error view
            return Container(
              child: Center(
                child: StreamBuilder<String>(
                  initialData: 'loading',
                  stream: Provider.of<UserDetailBloc>(context).bsStateMessage,
                  builder: (context, snapshot) {
                    return Text(snapshot.data);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
