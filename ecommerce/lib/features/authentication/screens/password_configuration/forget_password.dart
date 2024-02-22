import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //heading
            Text(TTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwItem,),
            Text(TTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSections*2,),

            //text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validationEmail,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections*2,),

            //submit button
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: ()=>controller.sendPasswordRestEmail(), child: const Text('Submit'))),

          ],
        ),
      ),
    );
  }
}