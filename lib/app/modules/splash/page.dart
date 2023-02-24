import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/widgets/logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<ConfigBloc>(),
      child: BlocListener<ConfigBloc, ConfigState>(
        listener: listener,
        child: const Scaffold(
          body: _Logo(),
        ),
      ),
    );
  }

  void listener(BuildContext context, ConfigState state) async {
    if (state is LoadedUserState) {
      Modular.to.navigate('/dashboard/');
    }

    if (state is UnLoggedState) {
      await Future.delayed(const Duration(seconds: 1));
      Modular.to.pushNamed('/auth/');
    }

    if (state is NoResidentialSelected) {
      await Future.delayed(const Duration(seconds: 1));
      Modular.to.pushNamed('/auth/choose');
    }
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 30,
      duration: const Duration(milliseconds: 500),
      controller: animate,
      child: const WalletMessagesLogo(),
    );
  }

  void animate(AnimationController controller) {
    controller.addListener(() async {
      if (controller.isCompleted) {
        controller.repeat(reverse: true);
        await Future.delayed(const Duration(milliseconds: 300));
      }
    });
  }
}
