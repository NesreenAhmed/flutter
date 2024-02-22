import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return ListTile(
      leading:const TCircularImage(
        image: TImage.user,
        width: 80,
        height: 80,
        padding: 0,
      ),
      title: Text(controller.user.value.fullName,style:Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
      subtitle: Text(controller.user.value.email,style:Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white), ),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: TColors.white,)),
      onTap: onPressed,

    );
  }
}