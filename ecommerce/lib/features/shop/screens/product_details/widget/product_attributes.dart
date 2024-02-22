import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //select attribute pricing and description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark?TColors.darkerGrey:Colors.grey,
          child: Column(
            children: [
              //title,price and stock status
              Row(
                children: [
                  const TSectionHeading(title: 'Variation',showActionButton: false,),
                  const SizedBox(width: TSizes.spaceBtwItem,),
                  //Actual price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(title:'Price:  ',smallSize: true,),

                          //actual price
                          Text('\$25',style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
                          const SizedBox(width: TSizes.spaceBtwItem,),
                          //sale price
                          const TProductPriceText(price: '20'),
                        ],
                      ),
                      //stock
                      Row(
                        children: [
                          const TProductTitleText(title:'Stock: ',smallSize: true,),
                          Text('In Stock',style: Theme.of(context).textTheme.titleMedium,),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              //variation description
             const TProductTitleText(
                 title:'This is the Descripiton of the product and it can go upto 4 max lines',
               smallSize: true,
               maxLines: 4,
             ),

            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem,),
        //Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const TSectionHeading(title: 'Colors',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItem/2,),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(text: 'Green', selected: true,onSelected: (value){},),
              TChoiceChip(text: 'Blue', selected: false,onSelected: (value){},),
              TChoiceChip(text: 'Yellow', selected: false,onSelected: (value){},),
            ],
          )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Sizes',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItem/2,),
           Wrap(
             spacing: 8,
             children: [
               TChoiceChip(text: 'EU 34', selected: true,onSelected: (value){},),
               TChoiceChip(text: 'EU 36', selected: false,onSelected: (value){},),
               TChoiceChip(text: 'EU 38', selected: false,onSelected: (value){},),
             ],
           )
          ],
        ),
      ],

    );
  }
}

