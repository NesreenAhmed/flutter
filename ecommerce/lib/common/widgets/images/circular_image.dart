import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.background,
    this.overlayColor,
    this.isNetworkImage = false,
    required this.image,
    this.fit = BoxFit.cover,
  });

  final double width, height, padding;
  final Color? background;
  final Color? overlayColor;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: background ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius:BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const TShimmerEffect(width: 55, height: 55,radius: 55,),
            errorWidget: (context,url,error)=>const Icon (Icons.error),

                )
              : Image(
                  fit: fit,
                  image: AssetImage(image) ,
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
