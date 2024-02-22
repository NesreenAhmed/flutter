import 'package:ecommerce/common/widgets/shimmer.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppBarTitle,style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey),),
          Obx(() {
            if(controller.profileLoading.value){
              //Display a shimmer loader while user profile is being loaded
              return const TShimmerEffect(width:80,height:15);
            }else{
              print('user:${controller.user.value.id} auth:${FirebaseAuth.instance.currentUser?.uid}');
              return Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),);
            }

          }),
        ],
      ),


      actions: [
        TCartCounterIcon(onPressed: (){},iconColor: TColors.white,)
      ],
    );
  }
}
