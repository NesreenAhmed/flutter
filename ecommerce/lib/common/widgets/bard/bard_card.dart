import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, required this.showBorder, this.onTap,

  });

  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap:onTap,
      child: TRoundedContainer(
        showBorder:showBorder,
        padding: const  EdgeInsets.all(TSizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //icon
            Flexible(
              child: TCircularImage(
                image: TImage.clothIcon,
                isNetworkImage: false,
                background: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItem / 2,
            ),
            //text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TBrandTitleWithVerifiedIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 Products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}