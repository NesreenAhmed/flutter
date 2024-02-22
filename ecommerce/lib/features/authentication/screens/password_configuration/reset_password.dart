import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=>Get.back(), icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //image
              Image(image: const AssetImage(TImage.deliveredEmailIllustration),width: THelperFunctions.screenWidth()*60,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //title and subtitle
              Text(TTexts.changeYourPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections,),
              Text(TTexts.changeYourPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //buttons
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed:()=>Get.offAll(()=>const LoginScreen()),child: const Text('Done'),),),
              const SizedBox(height: TSizes.spaceBtwItem,),
              SizedBox(width: double.infinity,child: TextButton(onPressed:()=>ForgetPasswordController.instance.resendPasswordRestEmail(email),child: const Text(TTexts.resendEmail),),),
              const SizedBox(height: TSizes.spaceBtwItem,),



            ],
          ),
        ),
      ),
    );
  }
}
