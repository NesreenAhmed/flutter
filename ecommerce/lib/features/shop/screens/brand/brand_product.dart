import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/bard/bard_card.dart';
import 'package:ecommerce/common/widgets/sortable/sortable_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Nike'),
        showBackArrow: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Brand details
               TBrandCard(showBorder: true),
               SizedBox(height: TSizes.spaceBtwSections,),

              TSortableProducts()
            ],
          ),
        ),
      ) ,
    );
  }
}
