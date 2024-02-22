import 'package:ecommerce/common/widgets/texts/brandtitle.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/utils/constants/colors.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines=1,
    this.textColor,
    this.iconColor=TColors.primary,
    this.brandTextSize=TextSizes.small,
    this.textAlign=TextAlign.center,
  });

  final String title;
  final int maxLines;
  final Color? textColor,iconColor;
  final TextSizes brandTextSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TBrandTitleText(
              title: title,
              color: textColor,
              maxLines: maxLines,
              textAlign: textAlign,
              brandTextSize: brandTextSize,
            ),
        ),
        const SizedBox(height: TSizes.xs,),
        Icon(Iconsax.verify5,color: iconColor ,size: TSizes.iconXs,),
      ],
    );
  }
}