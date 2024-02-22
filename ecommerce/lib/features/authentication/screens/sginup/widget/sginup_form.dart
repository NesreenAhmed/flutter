import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/features/authentication/screens/sginup/verify_email.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:ecommerce/features/authentication/screens/sginup/widget/termsandcondtion_checkbox.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //first & last name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstname,
                    validator: (value)=>TValidator.validateEmptyText('First name', value),
                    expands:false,
                    decoration: const InputDecoration(
                      labelText: TTexts.firstname,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputField,),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastname,
                    validator: (value)=>TValidator.validateEmptyText('Last name', value),
                    expands:false,
                    decoration: const InputDecoration(
                      labelText: TTexts.lastname,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            //username
            const SizedBox(height: TSizes.spaceBtwInputField,),
            TextFormField(
              controller: controller.username,
              validator: (value)=>TValidator.validateEmptyText('Username', value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),
            //email
            const SizedBox(height: TSizes.spaceBtwInputField,),
            TextFormField(
              controller: controller.email,
              validator: (value)=>TValidator.validationEmail(value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            //phoneNumber
            const SizedBox(height: TSizes.spaceBtwInputField,),
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value)=>TValidator.validatePhoneNumber(value),
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.phoneNumber,
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            //password
            const SizedBox(height: TSizes.spaceBtwInputField,),
            Obx(
                  ()=> TextFormField(
                    controller: controller.password,
                    validator: (value)=>TValidator.validatePassword(value),
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value= !controller.hidePassword.value,
                    icon:Icon(controller.hidePassword.value?Iconsax.eye_slash:Iconsax.eye),
                  ),
                ),
              ),
            ),
            //term and condition checkbox
            const TTermsAndConditionCheckbox(),
            const SizedBox(height: TSizes.spaceBtwSections,),
            //signup button
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: ()=>controller.signup(),
                child: const Text(TTexts.createAccount)),)
          ],
        )
    );
  }
}

