import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/sortable/sortable_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: TAppBar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child:TSortableProducts()
        ),
      ),
    );
  }
}

