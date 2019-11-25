import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post_app/common_widget/post_widget.dart';
import 'package:post_app/service/language/language_service.dart';
import 'package:post_app/ui/main_bloc.dart';
import 'package:post_app/model/post/post_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  /// language change
  StreamSubscription<String> _subscriptionLangChange;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _subscriptionLangChange = Provider.of<LanguageService>(context).bsLangOut.listen((lang) {
      print('MainPage: lang change : $lang');
      setState(() {});
    });

  }

  @override
  void dispose() {
    _subscriptionLangChange.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<LanguageService>(context).getStringKey('AppName')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Provider.of<MainBloc>(context).readFile();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<List<PostModel>>(
            initialData: [],
            stream: Provider.of<MainBloc>(context).bsListPost,
            builder: (context, snapshot) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return PostWidget(post: snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
