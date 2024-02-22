import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:ecommerce/common/widgets/bard/bard_card.dart';


class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: TColors.darkGrey,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
      child: Column(
        children: [
          //brand with products count
          const TBrandCard(showBorder: false),
          const SizedBox(height: TSizes.spaceBtwItem,),
          //brand top 3 products
          Row(
            children: images.map((image) =>brandTopProductImageWidget(image, context)).toList(),
          )
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image,context){
  final dark = THelperFunctions.isDarkMode(context);
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      backgroundColor: dark? TColors.darkerGrey:TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.all(TSizes.md),
      child:  Image(fit: BoxFit.contain,image: AssetImage(image),),
    ),
  );
}
