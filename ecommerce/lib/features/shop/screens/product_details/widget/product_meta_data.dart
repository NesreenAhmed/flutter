import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/product_image_details_slider.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price and sale tag
        Row(
          children: [
            TRoundedContainer(
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
            const SizedBox(width: TSizes.spaceBtwItem,),
            //price
            Text('\$250',style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            const SizedBox(width: TSizes.spaceBtwItem,),
            const TProductPriceText(price: '175',isLarge: true,),
            //Text('\$175',style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
          ],
        ),
        //title
        const SizedBox(height: TSizes.spaceBtwItem/1.5,),
        const TProductTitleText(title: 'Blue Nike Sports shoes'),
        const SizedBox(height: TSizes.spaceBtwItem/1.5,),
        //stoke status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(height: TSizes.spaceBtwItem,),
            Text('In Stock',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem/1.5),
        //brand
        TCircularImage(image: TImage.shoeIcon ,width: 32,height: 32,overlayColor: dark?TColors.white:TColors.black,),
        const TBrandTitleWithVerifiedIcon(title: 'Nike',brandTextSize: TextSizes.medium,),

        //Row(
          //mainAxisSize: MainAxisSize.min,
          //children: [
            //TCircularImage(image: TImage.shoeIcon ,width: 32,height: 32,overlayColor: dark?TColors.white:TColors.black,),
            //const TBrandTitleWithVerifiedIcon(title: 'Nike',brandTextSize: TextSizes.medium,),
          //],
        //),


      ],
    );
  }
}
