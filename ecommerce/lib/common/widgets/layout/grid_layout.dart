import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    this.maixAxisExtent=288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? maixAxisExtent;
  final Widget? Function(BuildContext,int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics:const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: maixAxisExtent,
      ),
      itemBuilder:itemBuilder,
    );
  }
}

