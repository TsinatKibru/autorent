import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingList extends StatelessWidget {
  final int itemCount;
  final double cardWidth;
  final double cardHeight;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoadingList({
    Key? key,
    this.itemCount = 2,
    this.cardWidth = 200,
    this.cardHeight = 230,
    this.borderRadius = 12.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          itemCount,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: cardWidth,
              height: cardHeight,
              margin: margin ?? const EdgeInsets.only(right: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
