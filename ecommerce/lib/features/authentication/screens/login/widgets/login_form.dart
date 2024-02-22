import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/sginup/signup.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItem),
        child: Column(
          children: [
            ///email
            TextFormField(
              controller: controller.email,
              validator: (value)=>TValidator.validationEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputField),
            ///password
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                validator: (value)=>TValidator.validatePassword(value),
                //validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value= !controller.hidePassword.value,
                    icon:Icon(controller.hidePassword.value?Iconsax.eye_slash:Iconsax.eye),
                  ),
                ),
              ),
            ),
            ///remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) =>controller.rememberMe.value=!controller.rememberMe.value)),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () =>Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.md),
            ///sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>Get.to(()=> const NavigationMenu()),
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            ///create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>Get.to(()=>const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}