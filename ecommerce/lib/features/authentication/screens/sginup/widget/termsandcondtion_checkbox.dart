import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:get/get.dart';

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=SignupController.instance;
    final dark=THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24,child: Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value)=>controller.privacyPolicy.value=!controller.privacyPolicy.value))),
        const SizedBox(width: TSizes.spaceBtwItem,),
        Text.rich(
            TextSpan(
                children: [
                  TextSpan(text: '${TTexts.iAgreeTo} ',style:Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: '${TTexts.privacyPolicy} ',style:Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark?TColors.white:TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark?TColors.white:TColors.primary,
                  ),),
                  TextSpan(text: 'and ',style:Theme.of(context).textTheme.bodySmall,),
                  TextSpan(text: '${TTexts.termsOfUse} ',style:Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark?TColors.white:TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark?TColors.white:TColors.primary,
                  ),),

                ]
            ))
      ],
    );
  }
}

