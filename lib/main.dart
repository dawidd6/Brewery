import 'package:brewery/app.dart';
import 'package:brewery/observer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  EquatableConfig.stringify = false;
  Bloc.observer = MyBlocObserver();
  setPathUrlStrategy();
  runApp(App());
}
