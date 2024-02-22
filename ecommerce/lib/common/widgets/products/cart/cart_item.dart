import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //image
        TRoundedImage(
          imageUrl: TImage.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)?TColors.darkerGrey:TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItem,),
        //title,price,size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'Nike'),
              const Flexible(child:TProductTitleText(title: 'Blue Nike Shoes',maxLines: 1,)),
              //Attributes
              Text.rich(
                  TextSpan(
                      children:[
                        TextSpan(text: 'Color',style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(text: ' Green',style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(text: 'Size',style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(text: 'UK 8',style: Theme.of(context).textTheme.bodyMedium),

                      ]
                  )
              )
            ],
          ),
        )
      ],

    );
  }
}
