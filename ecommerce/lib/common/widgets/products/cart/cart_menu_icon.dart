import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/utils/constants/colors.dart';


class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key, required this.onPressed, required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: (){ Get.to(()=>const CartScreen());}, icon:Icon(Iconsax.shopping_bag,color: iconColor,)),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),

            child:Text('  3 ',style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white,/*fontSizeFactor: 0.8*/)),

          ),
        )

      ],
    );
  }
}
