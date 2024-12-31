// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class CustomImage extends StatelessWidget {
//   final String imageUrl;
//   final double height;
//   final double width;
//   final BoxFit fit;
//   final BorderRadiusGeometry? borderRadius;
//   final Widget? loadingIndicator; // Custom loading indicator
//   final Widget? errorIcon; // Custom error icon or widget
//   final EdgeInsetsGeometry? padding; // Custom padding for the image
//   final bool showLoadingProgress; // To display progress during loading

//   const CustomImage({
//     Key? key,
//     required this.imageUrl,
//     required this.height,
//     required this.width,
//     this.fit = BoxFit.cover,
//     this.borderRadius,
//     this.loadingIndicator,
//     this.errorIcon,
//     this.padding,
//     this.showLoadingProgress = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius ?? BorderRadius.circular(0),
//       child: Padding(
//         padding: padding ?? EdgeInsets.zero,
//         child: Image.network(
//           imageUrl,
//           height: height,
//           width: width,
//           fit: fit,
//           loadingBuilder: (BuildContext context, Widget child,
//               ImageChunkEvent? loadingProgress) {
//             if (loadingProgress == null) {
//               // Image has finished loading
//               return child;
//             } else {
//               // While the image is loading, show a shimmer effect
//               return Center(
//                 child: loadingIndicator ??
//                     (showLoadingProgress
//                         ? Shimmer.fromColors(
//                             baseColor: Colors.grey[300]!,
//                             highlightColor: Colors.grey[100]!,
//                             child: Container(
//                               height: height,
//                               width: width,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const SizedBox()),
//               );
//             }
//           },
//           errorBuilder:
//               (BuildContext context, Object error, StackTrace? stackTrace) {
//             // If there's an error while loading the image, show a custom error widget
//             return Center(
//               child: errorIcon ??
//                   Icon(
//                     Icons.error,
//                     color: Colors.red,
//                     size: 50.0,
//                   ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget? loadingIndicator; // Custom loading indicator
  // Path to placeholder image
  final EdgeInsetsGeometry? padding; // Custom padding for the image
  final bool showLoadingProgress; // To display progress during loading

  const CustomImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingIndicator,
    this.padding,
    this.showLoadingProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: width,
          fit: fit,
          placeholder: (context, url) =>
              loadingIndicator ??
              (showLoadingProgress
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: height,
                        width: width,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox()),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/placeholder.png',
            height: height,
            width: width,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
