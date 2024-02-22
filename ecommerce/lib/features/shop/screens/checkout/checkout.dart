import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/products/cart/coupon_widget.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/features/shop/screens/cart/widget/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widget/billing_address_sectioon.dart';
import 'package:ecommerce/features/shop/screens/checkout/widget/billing_amount_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widget/billing_payment_Section.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //items in cart
              TCartItems(
                showAddRemoveButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Coupon textfield
              TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //billing section
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    //pricing
                    TBillingAmountSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItem,
                    ),
                    //divider
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItem,
                    ),
                    //payment method
                    TBillingPaymentSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItem,
                    ),
                    //address
                    TBillingAddressSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItem,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => SuccessScreen(
                image: TImage.successfulPayment,
                title: 'Payment Success!',
                subtitle: 'Your Order will be shipped soon!',
                onPressed: ()=>Get.offAll(()=>const NavigationMenu())));
          },
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
