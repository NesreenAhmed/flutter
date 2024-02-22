import 'package:ecommerce/features/shop/screens/sub_category/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/vertical_image_widget/vertical_image_text.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class THomecategories extends StatelessWidget {
  const THomecategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(image: TImage.shoeIcon,title: 'shoes',onTap: (){Get.to(()=>const SubCategoriesScreen());},);
        },
      ),
    );
  }
}