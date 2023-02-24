import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/utils/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Modular.setInitialRoute(Modular.initialRoute);
    Modular.setInitialRoute('/dashboard/');
    Modular.setNavigatorKey(Modular.get());

    return BlocBuilder<ConfigBloc, ConfigState>(
      bloc: Modular.get<ConfigBloc>(),
      builder: (context, state) {
        return GestureDetector(
          key: state.model.key,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: AppConfig.name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: AppColors.primary),
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          ),
        );
      },
    );
  }
}
