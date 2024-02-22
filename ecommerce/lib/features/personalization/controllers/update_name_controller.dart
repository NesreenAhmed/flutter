import 'package:ecommerce/data/respositories/user/user_repositry.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helper/network_manager.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///Controller to manage user-related functionality.
class UpdateNameController extends GetxController{
  static UpdateNameController get instance=>Get.find();

  final firstName=TextEditingController();
  final lastName=TextEditingController();
  final userController=UserController.instance;
  final userRepository=Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey=GlobalKey<FormState>();

  ///init user data when home screen appears
  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }
  ///Fetch user record
  Future<void>initializeNames()async{
    firstName.text=userController.user.value.firstName;
    lastName.text=userController.user.value.lastName;
  }

  Future<void>updateUserName()async{
    try{
     //start loading
     TFullScreenLoader.openLoadingDialog('We are updating your information', TImage.animation);
     //check internet connectivity
     //check internet connectivity
     final isConnected= await NetworkManager.instance.isConnected();
     if(!isConnected){
       TFullScreenLoader.stopLoading();
       return;
     }

     //Form validation
     if(!updateUserNameFormKey.currentState!.validate()){
       TFullScreenLoader.stopLoading();
       return;
     }

     //update user's first & last name in the firebase FireStore
     Map<String,dynamic> name={'FirstName':firstName.text.trim(),'LastName':lastName.text.trim()};
     await userRepository.updateSingleField(name);

     //update the Rx user value
     userController.user.value.firstName=firstName.text.trim();
     userController.user.value.lastName=lastName.text.trim();

     //Remove loader
     TFullScreenLoader.stopLoading();

     //show Success Message
      TLoaders.successSnackBar(title: 'Congratulations',message: 'Your Name has been updated.');
      //move to previous screen.
      Get.off(()=>const ProfileScreen());

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }

  }



}