import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_details.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()=>Get.to(()=>const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductsShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : Colors.white,
        ),
        child: Column(
          children: [
            //thumbnail wishlist discount tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //thumbnail
                  const TRoundedImage(
                    imageUrl: TImage.productImage1,
                    applyImageRadius: true,
                  ),
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
                          TCircularIcon(icon: Iconsax.heart5, color: Colors.red))
                ],
              ),
            ),


            //details
             const Padding(
              padding:  EdgeInsets.only(left: TSizes.sm),
              child: Column(
                children: [
                   TProductTitleText(title:'Blue nike Air shoes',smallSize: true, ),
                   SizedBox(height: TSizes.spaceBtwItem/2,),
                   TBrandTitleWithVerifiedIcon(title: 'Nike'),
                ],
              ),
            ),
            Spacer(),
            //price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
               const Padding(
                  padding:  EdgeInsets.only(left: TSizes.sm),
                  child:  TProductPriceText(price:'35.0'),
                ),
                //add cart button
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
    );
  }
}


