import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //drop down
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon (Iconsax.sort)),
            items: [
              'Name','Higher price','Lower price','Sale','Newest','Popularity']
                .map((option) => DropdownMenuItem(value: option,child: Text(option))).toList(),
            onChanged: (value){}
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),
        //product
        TGridLayout(itemCount: 10, itemBuilder: (_,index)=>const TProductCardVertical())
      ],
    );
  }
}
