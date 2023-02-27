import 'package:dio/dio.dart';
import 'package:fields/app/database/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/modules/dashboard/module.dart';
import 'package:fields/app/modules/splash/page.dart';
import 'package:fields/app/utils/preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => DatabaseConfig(),
      isSingleton: true,
      isLazy: false,
    ),
    Bind((i) => GlobalKey<NavigatorState>()),
    Bind((i) => Preferences()),
    Bind(
      (i) => Dio(
        BaseOptions(
          responseType: ResponseType.json,
          contentType: 'application/json',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
    ),
    ModuleRoute('/dashboard', module: DashboardModule()),
  ];
}
