import 'package:brewery/app.dart';
import 'package:brewery/observer.dart';
import 'package:brewery/styles/brewery_images.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  // Don't print state variables
  EquatableConfig.stringify = false;
  // Set Bloc observer to monitor changes
  Bloc.observer = MyBlocObserver();
  // Ensure flutter engine is initialized now
  WidgetsFlutterBinding.ensureInitialized();
  // Load SVGs
  await BreweryImages.preCacheAll();
  // Remove # from URLs
  setPathUrlStrategy();
  // Run app
  runApp(App());
}
