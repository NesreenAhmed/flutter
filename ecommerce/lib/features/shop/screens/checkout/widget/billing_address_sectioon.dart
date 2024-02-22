import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: TSectionHeading(title: 'Shipping Address',buttonTitle: 'Change',onPressed: (){},),
        ),
        Text('Nesreen Ahmed',style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: TSizes.spaceBtwItem/2,),
        Row(
          children: [
            const Icon(Icons.phone,color: Colors.grey,size: 16,),
            const SizedBox(height: TSizes.spaceBtwItem),
            Text('01008273360',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem/2),
        Row(
          children: [
            const Icon(Icons.location_history,color: Colors.grey,size: 16,),
            const SizedBox(height: TSizes.spaceBtwItem),
            Expanded(child: Text('South Liana, Maine 87695, USA',style: Theme.of(context).textTheme.bodyMedium,)),
          ],
        ),
      ],
    );
  }
}
