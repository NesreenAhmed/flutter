import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          color: THelperFunctions.isDarkMode(context)?TColors.white:TColors.black,
          width: 32,
          height: 32,
          size: TSizes.md,
          backgroundColor: THelperFunctions.isDarkMode(context)?TColors.darkerGrey:TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItem,),
        Text('2',style: Theme.of(context).textTheme.titleSmall,),
        const SizedBox(width: TSizes.spaceBtwItem,),
        const TCircularIcon(
            icon: Iconsax.add,
            color: TColors.white,
            width: 32,
            height: 32,
            size: TSizes.md,
            backgroundColor:TColors.primary

        ),
      ],
    );
  }
}

