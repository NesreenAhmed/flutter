import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //header
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  //const SizedBox(height: TSizes.spaceBtwSections,),
                  //user profile card
                  TUserProfileTitle(onPressed:() => Get.to(() => const ProfileScreen()) ),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),
            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Account settings
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItem,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add remove products and move to checkout',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and completed Orders',
                    onTap: () {Get.to(()=>const OrderScreen());},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My coupons',
                    subTitle: 'List of all the discount coupons',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification messages',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected',
                    onTap: () {},
                  ),

                  //APP Settings
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItem,
                  ),
                  const TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase'),

                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocations',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search results is safe for all ages',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: (){
                        AuthenticationRepository.instance.logout();
                        }
                        , child: const Text('Logout')
                        ,),

                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections*2.5,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
