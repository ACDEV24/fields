import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FieldsLogo extends StatelessWidget {
  final double? height;
  final double? width;

  const FieldsLogo({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: const Center(
        child: Icon(Icons.wallet),
      ),
    );
  }
}
