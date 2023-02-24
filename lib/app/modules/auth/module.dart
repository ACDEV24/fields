import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/modules/auth/bloc/bloc.dart';
import 'package:fields/app/modules/auth/repository.dart';

import 'page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => AuthBloc(
        repository: i.get(),
        prefs: i.get(),
      ),
    ),
    Bind(
      (i) => AuthRepository(
        dio: i.get(),
        prefs: i.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const AuthPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
