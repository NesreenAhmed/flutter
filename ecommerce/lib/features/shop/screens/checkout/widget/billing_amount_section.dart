import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //sub total
        Padding(
          padding: const EdgeInsets.only(left: 5.0,top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal',style: Theme.of(context).textTheme.bodyMedium,),
              Text('\$256.0',style: Theme.of(context).textTheme.bodyMedium,),

            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem/2,),
        //Shipping fee
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Fee',style: Theme.of(context).textTheme.bodyMedium,),
              Text('\$6.0',style: Theme.of(context).textTheme.labelLarge,),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItem/2,),
        //Tax fee
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,),
              Text('\$6.0',style: Theme.of(context).textTheme.labelLarge,),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItem/2,),
        //Order total
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,),
              Text('\$268.0',style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
        ),
      ],
    );
  }
}
