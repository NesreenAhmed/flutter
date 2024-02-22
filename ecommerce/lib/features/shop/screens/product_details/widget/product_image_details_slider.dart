import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child:  Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius*2),
                child: Image(image: AssetImage(TImage.productImage1),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_,__)=>const SizedBox(width: TSizes.spaceBtwItem,),
                  itemBuilder: (_,index)=> TRoundedImage(
                    width: 80,
                    backgroundColor:dark ?TColors.dark:TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageUrl: TImage.productImage1,

                  ),
                ),
              ),
            ),
            //App bar
            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(icon: Iconsax.heart5, color: Colors.red)
              ],
            )
          ],
        ),
      ),
    );
  }
}