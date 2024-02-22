import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/bard/brand_show_case.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Brands
                const TBrandShowcase(images: [
                  TImage.productImage2,
                  TImage.productImage3,
                  TImage.productImage4
                ]),

                const TBrandShowcase(images: [
                  TImage.productImage2,
                  TImage.productImage3,
                  TImage.productImage4
                ]),
                const SizedBox(height: TSizes.spaceBtwItem,),
                //products
                TSectionHeading(title: 'You might like', onPressed: () {},),
                const SizedBox(height: TSizes.spaceBtwItem,),

                TGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => const TProductCardVertical(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),

              ],
            ),
          ),
        ],
    );
  }
}
