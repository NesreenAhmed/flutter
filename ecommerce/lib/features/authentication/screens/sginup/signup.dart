import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/social_button.dart';
import 'package:ecommerce/common/widgets/form_divider.dart';
import 'package:get/get.dart';
import 'package:ecommerce/features/authentication/screens/sginup/widget/sginup_form.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Title
            Text(TTexts.signUpTitle,style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections,),
            //Form
            const TSignupForm(),
            const SizedBox(height: TSizes.spaceBtwSections,),
            TFormDivider(diverText: TTexts.orSignUpWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwItem,),
            const TSocialButton(),
          ],
        ),
        ),
      ),
    );
  }
}



