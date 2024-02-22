import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/bottom_add_to_cart_widget.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/product_image_details_slider.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/product_meta_data.dart';
import 'package:ecommerce/features/shop/screens/product_details/widget/rating_share_widget.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar:const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image slider
            const TProductImageSlider(),
            //product details
            Padding(
                padding: const EdgeInsets.only(right: TSizes.defaultSpace,left: TSizes.defaultSpace,bottom: TSizes.defaultSpace),
            child: Column(
              children: [
                //ratting
               const TRatingAndShare(),
                //price,title,stoke,and brand
                const TProductMetaData(),

                //Attributes
               const  TProductAttributes(),
                const SizedBox(height: TSizes.spaceBtwSections,),
                //checkout button
                SizedBox(width:double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'),),),
                const SizedBox(height: TSizes.spaceBtwSections,),

                //description
                const TSectionHeading(title: 'Description',showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItem,),

               const ReadMoreText('This is a product description for blue Nike Sleeve less vest. There are more things that can be add but im just practicing and nothing else. ',
                trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Less',
                  moreStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                  lessStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                ),
                //reviews
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItem,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TSectionHeading(title: 'Reviews (199)',showActionButton: false,),
                    IconButton(onPressed: (){Get.to(()=>const ProductReviewsScreen());},icon: const Icon(Iconsax.arrow_right_3,size: 18,),)
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}

