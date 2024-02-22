import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/appbar/tabbar.dart';
import 'package:ecommerce/common/widgets/bard/brand_show_case.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/features/shop/screens/brand/all_brands.dart';
import 'package:ecommerce/features/shop/screens/store/widget/category_tab.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/bard/bard_card.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/bard/bard_card.dart';
import 'package:get/get.dart';
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () {}, iconColor: TColors.white),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwItem,
                        ),
                        //search bar
                        const TSearchContainer(
                          text: 'Search in Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        //featured brands
                        TSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () {Get.to(()=>const AllBrandsScreen());},
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItem / 1.5,
                        ),
                        //Brands grid
                        TGridLayout(
                            itemCount: 4,
                            maixAxisExtent: 80,
                            itemBuilder: (_, index) {
                              return const TBrandCard(showBorder:false ,);
                            })
                      ],
                    ),
                  ),
                  bottom:const TTabBar(tabs: [
                    Tab(child: Text('sports'),),
                    Tab(child: Text('Furniture'),),
                    Tab(child: Text('Electronics'),),
                    Tab(child: Text('Clothes'),),
                    Tab(child: Text('Cosmetics'),),
                  ])),
            ];
          },
          body:TabBarView(
              children: [
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),

              ]),
        ),
      ),
    );
  }
}


