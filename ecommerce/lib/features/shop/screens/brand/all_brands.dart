import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/bard/bard_card.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/sortable/sortable_products.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_product.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              const TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItem,
              ),
              //Brands
              TGridLayout(
                itemCount: 10,
                maixAxisExtent: 80,
                itemBuilder: (context, index) => TBrandCard(
                  showBorder: true,
                  onTap: () => Get.to(() => const BrandProducts()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
