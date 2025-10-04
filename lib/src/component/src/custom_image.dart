import 'package:flutter/material.dart';


class CustomNetworkImageBuilder extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final Function()? onTap;
  final Function()? onTapErrorWidget;

  const CustomNetworkImageBuilder(
      {super.key, required this.imageUrl, this.width, this.height,
        this.errorWidget, this.onTap, this.onTapErrorWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: AspectRatio(
          aspectRatio: 1,
          child: GestureDetector(
            onTap: onTap,
            child: Image.network(
              imageUrl!,
              errorBuilder: (context, object, errorObject) {
                return GestureDetector(onTap: onTapErrorWidget, child: errorWidget ?? Image.network('https://res.cloudinary.com/jnappdev/image/upload/v1718057643/musicium/bykfrfphyn81q68yptyw.jpg', width: width, height: height,));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // Image is fully loaded or failed—show the image
                  return child;
                }
                // Show progress indicator during loading
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null, // Indeterminate if total bytes unknown
                  ),
                );
              },
            ),
          ),
        ));
  }
}
class SearchImageWidget extends CustomNetworkImageBuilder {
  SearchImageWidget({super.key, required super.imageUrl, super.onTap, super.onTapErrorWidget})
      : super(width: null, height: null, errorWidget: Image.network('https://res.cloudinary.com/jnappdev/image/upload/v1718057643/musicium/bykfrfphyn81q68yptyw.jpg'));
}