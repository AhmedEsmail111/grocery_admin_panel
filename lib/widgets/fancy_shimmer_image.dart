import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class FancyImage extends StatelessWidget {
  const FancyImage(
      {Key? key,
      required this.isDark,
      required this.imageUrl,
      this.imageWidth,
      this.imageHeight})
      : super(key: key);
  final bool isDark;
  final String imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FancyShimmerImage(
        errorWidget: Container(
          width: imageWidth ?? width * 0.25,
          height: imageHeight ?? width * 0.22,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(12),
            color: isDark ? Colors.white54 : Colors.black26,
          ),
          child: Center(
            child: Text(
              'no network!',
              style: const TextStyle().copyWith(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
        imageUrl: imageUrl,
        width: imageWidth ?? width * 0.25,
        height: imageHeight ?? width * 0.22,
        boxFit: BoxFit.cover,
      ),
    );
  }
}
