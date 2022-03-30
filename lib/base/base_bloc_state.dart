import 'package:flutter/material.dart';
import 'package:post_app/base/base_bloc.dart';
import 'package:post_app/base/base_state.dart';

abstract class BaseBlocState<T extends StatefulWidget, B extends BaseBloc>
    extends BaseState<T> {
  B getBloc() => getComponent<B>();
}
