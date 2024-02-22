import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/widget/progress_indicator_and_rating.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utilty.dart';
import 'package:flutter/material.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3,child: Text('4.8',style: Theme.of(context).textTheme.displayLarge,)),
       const Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(text:'5',value: 1.0,),
              TRatingProgressIndicator(text:'4',value: 0.8,),
              TRatingProgressIndicator(text:'3',value: 0.6,),
              TRatingProgressIndicator(text:'2',value: 0.4,),
              TRatingProgressIndicator(text:'1',value: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}