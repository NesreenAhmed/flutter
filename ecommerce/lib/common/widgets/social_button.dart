import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:get/get.dart';


class TSocialButton extends StatelessWidget {
  const TSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.darkerGrey),
              borderRadius: BorderRadius.circular(200)),
          child: IconButton(
            onPressed: () =>controller.googleSignIn(),
            icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImage.google)),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwSections),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.darkerGrey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImage.facebook)),
          ),
        ),
      ],
    );
  }
}
