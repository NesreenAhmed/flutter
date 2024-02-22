import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_text.dart';
import 'package:ecommerce/features/shop/screens/cart/widget/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart',style:Theme.of(context).textTheme.headlineSmall ,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItems(),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(onPressed: (){Get.to(()=>const CheckoutScreen());},child:const Text('Checkout \$256.0'),),
      ) ,
    );
  }
}
