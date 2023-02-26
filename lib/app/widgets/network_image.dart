import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_extensions/dart_extensions.dart';

class CachedImage extends StatelessWidget {
  final double? width;
  final double? height;
  final int millisecondsCache;
  final String? url;
  final BoxFit boxFit;
  final BoxFit? placeHolderFit;
  final bool available;
  final String errorImage;
  final Widget? onErrorWidget;

  const CachedImage({
    Key? key,
    this.width,
    this.height,
    this.placeHolderFit,
    this.millisecondsCache = 900000,
    required this.url,
    this.boxFit = BoxFit.cover,
    this.available = true,
    this.errorImage = 'default.png',
    this.onErrorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmptyOrNull) return const SizedBox.shrink();

    return CachedNetworkImage(
      placeholder: (_, __) {
        return _DefaultImage(
          errorImage: errorImage,
          height: height,
          width: width,
          boxFit: placeHolderFit ?? boxFit,
        );
      },
      imageUrl: url!,
      height: height,
      width: width,
      fit: boxFit,
      color: available ? null : Colors.grey,
      colorBlendMode: BlendMode.saturation,
      errorWidget: (_, __, ___) {
        if (onErrorWidget != null) {
          return onErrorWidget!;
        }

        return _DefaultImage(
          errorImage: errorImage,
          height: height,
          width: width,
          boxFit: boxFit,
        );
      },
    );
  }
}

class _DefaultImage extends StatelessWidget {
  const _DefaultImage({
    Key? key,
    required this.errorImage,
    required this.height,
    required this.width,
    required this.boxFit,
  }) : super(key: key);

  final String errorImage;
  final double? height;
  final double? width;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        'assets/loading.gif',
      ),
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
