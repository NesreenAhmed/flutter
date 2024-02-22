import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/ratings/rating_indcator.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/widget/progress_indicator_and_rating.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/widget/rating_progress_indicator.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/widget/user_review_card.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utilty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar:const TAppBar(title: Text('Reviews & Rating'),showBackArrow: true,),

      //body
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text('Ratings and reviews are verified and are from people who use the same type of device that you use'),
            const SizedBox(height: TSizes.spaceBtwItem,),

            //overall product ratings
           const TOverallProductRating(),

            TRatingBarIndicator(rating: 4.5,),
            Text('12,611',style: Theme.of(context).textTheme.bodySmall,),
            const SizedBox(height:TSizes.spaceBtwSections ,),

            //user reviews list
            UserReviewCard(),
            
          ],
        ),
        ),
      ),
    );
  }
}

