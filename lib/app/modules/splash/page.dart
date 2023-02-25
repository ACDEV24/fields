import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fields/app/widgets/logo.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Logo(),
    );
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
      child: const FieldsLogo(),
    );
  }

  void animate(AnimationController controller) {
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate('/dashboard/');
    });

    controller.addListener(
      () async {
        if (controller.isCompleted) {
          controller.repeat(reverse: true);
          await Future.delayed(const Duration(milliseconds: 300));
        }
      },
    );
  }
}
