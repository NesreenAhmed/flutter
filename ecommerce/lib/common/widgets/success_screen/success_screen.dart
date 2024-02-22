import 'package:ecommerce/common/styles/spacing_styles.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key,required this.image,required this.title,required this.subtitle,required this.onPressed});

  final String image,title,subtitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpaceStyle.paddingWithAppBarHeight*2,
          child:Column(
            children: [
              //Image
             //Lottie.asset(image,width: MediaQuery.of(context).size.width*0.6),
              Image(image:AssetImage(image,),width: THelperFunctions.screenWidth()*0.6,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Title
              Text(title,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections,),
              Text(subtitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              SizedBox(width: double.infinity,child: ElevatedButton(onPressed:onPressed,child: const Text('Continue'),),),
              const SizedBox(height: TSizes.spaceBtwItem,),


            ],
          ) ,
        ),
      ),
    );
  }
}
