import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/module.dart';
import 'package:fields/app/utils/preferences.dart';
import 'package:fields/app/widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  await prefs.init();

  runZonedGuarded(
    () {
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        FlutterError.presentError(errorDetails);
        AppConfig.logError(errorDetails, errorDetails.stack);
      };
      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (Object error, StackTrace stackTrace) {
      AppConfig.logError(error, stackTrace);
    },
  );
}
