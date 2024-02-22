import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/features/personalization/controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(UpdateNameController());
    return Scaffold(
      //custom Appbar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            ///heading
            Text('Use real name for easy verification.This name will appear on several pages.',style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSections,),
            ///Text field and button
            Form(
              key: controller.updateUserNameFormKey,
                child:Column(
                  children: [
                   TextFormField(
                     controller: controller.firstName,
                     validator: (value)=>TValidator.validateEmptyText('First name', value),
                     expands: false,
                     decoration: const InputDecoration(labelText: TTexts.firstname,prefixIcon: Icon(Iconsax.user)),
                   ) ,
                    const SizedBox(height: TSizes.spaceBtwInputField,),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value)=>TValidator.validateEmptyText('Last name', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: TTexts.lastname,prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            
            ///save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=>controller.updateUserName(),child: const Text('Save'),),
            )
          ],
        ),
      ),
    );
  }
}
