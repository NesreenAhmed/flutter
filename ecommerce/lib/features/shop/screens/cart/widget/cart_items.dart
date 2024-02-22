import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key,
    this.showAddRemoveButton=true
  });

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_,__)=>const SizedBox(height: TSizes.spaceBtwSections,),
      itemCount: 3,
      itemBuilder: (_,index)=>Column(
        children: [
          const TCartItem(),
          if(showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItem,),

          if(showAddRemoveButton)
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Extra space
                  SizedBox(width: 70,),
                  //Add and remove buttons
                  TProductQuantityWithAddRemoveButton(),
                ],
              ),
              TProductPriceText(price: '256'),

            ],
          )
        ],
      ),
    );
  }
}
