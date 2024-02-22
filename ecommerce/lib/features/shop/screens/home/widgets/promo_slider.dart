import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/features/shop/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key, required this.banners,
  });

  final List<String>banners;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index,_)=>controller.updatePageIndicator(index)
          ),
          items: banners.map((url) =>TRoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItem,),
        Obx(
            () =>Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=0;i<banners.length;i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  backgroundColor: controller.carousalCurrentIndex.value==i ?TColors.primary:Colors.grey,
                  margin:const EdgeInsets.only(right:10 ),
                ),


            ],
          ),
        )
      ],
    );
  }
}

