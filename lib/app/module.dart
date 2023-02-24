import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/modules/auth/module.dart';
import 'package:fields/app/modules/dashboard/module.dart';
import 'package:fields/app/modules/splash/page.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/config/repository.dart';
import 'package:fields/app/utils/interceptors/errors.dart';
import 'package:fields/app/utils/preferences.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => ConfigBloc(
        prefs: i.get(),
        repository: i.get(),
      )..add(const InitEvent()),
    ),
    Bind((i) => GlobalKey<NavigatorState>()),
    Bind(
      (i) => ConfigRepository(
        dio: i.get(),
        prefs: i.get(),
      ),
    ),
    Bind((i) => Preferences()),
    Bind(
      (i) {
        final token = 'Bearer ${i.get<Preferences>().token?.accessToken ?? ''}';

        return Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            responseType: ResponseType.json,
            contentType: 'application/json',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token,
            },
          ),
        )..interceptors.add(ErrorsInterceptor());
      },
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
    ),
    ModuleRoute('/dashboard', module: DashboardModule()),
    ModuleRoute('/auth', module: AuthModule()),
  ];
}
