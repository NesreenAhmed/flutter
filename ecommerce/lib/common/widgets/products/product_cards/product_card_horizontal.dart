import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductCarHorizontal extends StatelessWidget {
  const TProductCarHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark?TColors.darkerGrey:TColors.lightContainer,
      ),
      child: Row(
        children: [
          //thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark?TColors.dark:TColors.light,
            child: Stack(
              children: [
                const SizedBox(
                  height: 120,
                    width: 120
                    ,child: TRoundedImage(imageUrl: TImage.productImage1,applyImageRadius: true)),
               // const SizedBox(height: TSizes.spaceBtwSections,),
                //sale
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ),
                ),
                //fav button
                 const Positioned(
                    top: 0,
                    right: 0,
                    child:
                    TCircularIcon(icon: Iconsax.heart5, color: Colors.red,
                    ),
                 ),
              ],
            ),
          ),
          //details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm,top: TSizes.sm),
              child: Column(
                children: [
                 const Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     TProductTitleText(title: 'Blue Nike Shoes',smallSize: true,),
                     SizedBox(height: TSizes.spaceBtwItem/2,),
                     TBrandTitleWithVerifiedIcon(title: 'Nike')
                 ],
                 ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //pricing
                      const Flexible(child:  TProductPriceText(price: '256.0')),
                      //add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: TSizes.iconLg*1.2,
                          height: TSizes.iconLg*1.2,
                          child: Center(child: Icon(Iconsax.add,color: Colors.white,)),

                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
