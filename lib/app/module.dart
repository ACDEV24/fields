import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/modules/dashboard/module.dart';
import 'package:fields/app/modules/splash/page.dart';
import 'package:fields/app/utils/preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GlobalKey<NavigatorState>()),
    Bind((i) => Preferences()),
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
