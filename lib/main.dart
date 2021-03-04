import 'package:brewery/app.dart';
import 'package:brewery/observer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  debugRepaintRainbowEnabled = false;
  EquatableConfig.stringify = false;
  Bloc.observer = MyBlocObserver();
  runApp(App());
}
