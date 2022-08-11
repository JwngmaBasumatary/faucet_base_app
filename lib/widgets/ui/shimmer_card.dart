import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    Key? key, this.radius,
  }) : super(key: key);
  final double height;
  final double width;
  final double? radius;

  final Color? baseColor;
  final Color? highlightColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(radius ?? 6)),
        ),
      ),
    );
  }
}
