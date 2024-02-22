import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/device/device_utilty.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/features/shop/controllers/home_controller.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  THomeAppBar(),
                   SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //searchbar
                   TSearchContainer(
                    text: 'Search in Store',
                  ),
                   SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //categories
                  Padding(
                    padding:  EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                         TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                         SizedBox(
                          height: TSizes.spaceBtwItem,
                        ),
                        //category
                        THomecategories()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //promo slider
                  const TPromoSlider(banners: [TImage.promoBanner1,TImage.promoBanner2,TImage.promoBanner3],),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //heading
                  TSectionHeading(
                    title: 'Popular Categories',
                    onPressed: (){Get.to(()=>const AllProducts());},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItem,
                  ),
                  //popular product
                  TGridLayout(itemCount: 4, itemBuilder: (_,index)=>const TProductCardVertical()),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

