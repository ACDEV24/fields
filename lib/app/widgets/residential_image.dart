import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fields/app/widgets/network_image.dart';

class ResidentialImage extends StatelessWidget {
  final String? text;
  final String? photo;
  final double sigmaX;
  final double sigmaY;
  final double imageHeight;
  final double borderRadius;
  final double fontSize;
  final double textBackgroundOpacity;

  const ResidentialImage({
    Key? key,
    this.text,
    required this.photo,
    this.sigmaX = 0.10,
    this.sigmaY = 0.10,
    this.imageHeight = 200.0,
    this.borderRadius = 12.0,
    this.fontSize = 24.0,
    this.textBackgroundOpacity = 0.50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: CachedImage(
              url: photo,
              height: imageHeight,
              width: double.infinity,
            ),
          ),
          if (text != null)
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(textBackgroundOpacity),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
