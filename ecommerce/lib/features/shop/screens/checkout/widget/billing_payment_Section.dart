import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: TSectionHeading(title: 'Payment Method',buttonTitle: 'Change',onPressed: (){},),
        ),
        const SizedBox(height: TSizes.spaceBtwItem/2,),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark?TColors.light:TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImage.paypal),fit: BoxFit.contain,),
            ),
            const SizedBox(width: TSizes.spaceBtwItem/2,),
            Text('Paypal',style: Theme.of(context).textTheme.bodyLarge,),

          ],
        )
      ],
    );
  }
}
