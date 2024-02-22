import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/shimmer.dart';
import 'package:ecommerce/common/widgets/texts/seaction_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/widget/change_name.dart';
import 'package:ecommerce/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  //profile picture
                  Obx((){
                    final networkImage=controller.user.value.profilePicture;
                    final image=networkImage.isNotEmpty?networkImage:TImage.user;
                    return controller.imageUploader.value
                        ?const TShimmerEffect(width: 80, height: 80,radius: 80,)
                        : TCircularImage(image: image,width: 100,height: 100,isNetworkImage: networkImage.isNotEmpty,);
                  }),
                  const SizedBox(height: TSizes.spaceBtwItem,),
                  TextButton(onPressed: ()=>controller.uploadUserProfilePicture(), child: const Text('Change profile picture'),),
                ],
              ),
            ),
            //details
            const SizedBox(height: TSizes.spaceBtwItem/2,),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItem,),
            const TSectionHeading(title: 'Profile Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItem,),
            
            TProfileMenu(onPressed: ()=>Get.to(()=>const ChangeName()), title: 'Name', value: controller.user.value.fullName),
            TProfileMenu(onPressed: (){}, title: 'Username', value:  controller.user.value.username),

            const SizedBox(height: TSizes.spaceBtwItem,),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItem,),

            const TSectionHeading(title: 'Personal Information',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItem,),

            TProfileMenu(onPressed: (){}, title: 'User Id', value: controller.user.value.id),
            TProfileMenu(onPressed: (){}, title: 'E-mail', value: controller.user.value.email),
            TProfileMenu(onPressed: (){}, title: 'Phone Number', value: controller.user.value.phoneNumber),
            TProfileMenu(onPressed: (){}, title: 'Gender', value: 'Female'),
            TProfileMenu(onPressed: (){}, title: 'Date of Birth', value: '5-Feb-2001'),
            const Divider(),
            const SizedBox(height:TSizes.spaceBtwItem ,),
            Center(
              child: TextButton(
                child:const Text('Delete Account',style: TextStyle(color: Colors.red),),
                onPressed: ()=>controller.deleteAccountWarningPopup(),
              ),
            )


          ],
        ),
      ),
    );
  }
}

