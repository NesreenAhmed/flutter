import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size=TSizes.lg,
    required this.icon,
    required this.color,
    this.backgroundColor,
    this.onPressed,

  });

  final double? width,height,size;
  final IconData icon;
  final Color color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:backgroundColor!=null?backgroundColor!:THelperFunctions.isDarkMode(context)?TColors.black.withOpacity(0.9):Colors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed,icon:Icon(icon,color: color,size: size,),),
    );
  }
}
