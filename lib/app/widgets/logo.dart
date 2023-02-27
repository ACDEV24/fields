import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FieldsLogo extends StatelessWidget {
  final double? height;
  final double? width;

  const FieldsLogo({
    Key? key,
    this.height = 100.0,
    this.width = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Center(
        child: Image.asset(
          'assets/logo.png',
          height: height,
          width: width,
        ),
      ),
    );
  }
}
