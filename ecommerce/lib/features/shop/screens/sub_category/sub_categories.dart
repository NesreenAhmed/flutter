import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Sports '
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //banner
              const TRoundedImage(imageUrl: TImage.promoBanner3,width: double.infinity,applyImageRadius: true,),
              const SizedBox(height: TSizes.defaultSpace,),
              //sub cat
              Column(
                children: [
                  //heading
                  TSectionHeading(title: 'Sports Shoes',onPressed: (){},),
                  const SizedBox(height: TSizes.spaceBtwItem/2,),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                        separatorBuilder: (context,index)=>const SizedBox(width: TSizes.spaceBtwItem,),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>const TProductCarHorizontal()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
