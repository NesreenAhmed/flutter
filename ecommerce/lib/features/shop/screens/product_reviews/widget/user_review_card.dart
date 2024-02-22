import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/products/ratings/rating_indcator.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImage.userProfileImage1),
                ),
                const SizedBox(width: TSizes.spaceBtwItem,),
                Text('John Doe',style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem,),

        //review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItem,),
            Text('01-Nov-2023',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem,),
        const ReadMoreText('The user interface of the app is quite intvitive. I was able to navigate and make purchases seamlessly.Great job!',
        trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'Show Less',
          trimCollapsedText: 'Show more',
          moreStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: TColors.primary),
          lessStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItem,),

        //company review
        TRoundedContainer(
          backgroundColor: dark?TColors.darkerGrey:Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("T'S Store",style: Theme.of(context).textTheme.titleMedium,),
                    Text(' 02-Nov-2023',style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem,),
                const ReadMoreText('The user interface of the app is quite intvitive. I was able to navigate and make purchases seamlessly.Great job!',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'Show Less',
                  trimCollapsedText: 'Show more',
                  moreStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: TColors.primary),
                  lessStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: TColors.primary),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),

      ],
    );
  }
}
