import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItem extends StatelessWidget {
  const TOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_,__)=>const SizedBox(height: TSizes.spaceBtwItem,),
      itemBuilder: (_,index)=> TRoundedContainer(
        padding:const EdgeInsets.all(TSizes.md) ,
        showBorder: true,
        backgroundColor:dark?TColors.dark:TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //row1
            Row(
              children: [
                const Icon(Iconsax.ship),
                const SizedBox(width: TSizes.spaceBtwItem/2,),
                //2 status and date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary,fontWeightDelta: 1),

                      ),
                      Text('07-Nov-2023',style: Theme.of(context).textTheme.headlineSmall,)
                    ],
                  ),
                ),
                //3-Icon
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34,size: TSizes.iconSm,)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItem,),
            //row2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.tag),
                      const SizedBox(width: TSizes.spaceBtwItem/2,),
                      //2 status and date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text('[#256f2]',style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: TSizes.spaceBtwItem/2,),
                      //2 status and date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Date',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text('10-Nov-2023',style: Theme.of(context).textTheme.titleMedium,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
