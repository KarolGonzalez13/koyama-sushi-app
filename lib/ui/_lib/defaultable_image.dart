import 'package:flutter/material.dart';

class DefaultableImage extends StatelessWidget {
  String? src;
  String defaultSrc;
  double dimension;
  BoxFit fit;
  Animation<double> opacity;

  DefaultableImage({
    super.key,
    required this.src,
    required this.defaultSrc,
    required this.dimension,
    required this.fit,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src ?? '',
      width: dimension,
      height: dimension,
      opacity: opacity,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.network(
          defaultSrc,
          width: dimension,
          height: dimension,
          opacity: opacity,
          fit: fit,
        );
      },
    );
  }
}
