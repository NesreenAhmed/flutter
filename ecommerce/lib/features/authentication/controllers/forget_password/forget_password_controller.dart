import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helper/network_manager.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance=>Get.find();

  ///variables
  final email =TextEditingController();
  GlobalKey<FormState>forgetPasswordFormKey=GlobalKey<FormState>();

  ///send Rest Email
  sendPasswordRestEmail()async{
    try{
      //start loader
      TFullScreenLoader.openLoadingDialog('Processing your request...', TImage.animation);

      //check internet connectivity
      final isConnected=await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }
      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordRestEmail(email.text.trim());
      //remove loader
      TFullScreenLoader.stopLoading();
      //show success screen
      TLoaders.successSnackBar(title: 'Email Sent',message: 'Email Link sent to Rest your password'.tr);
      //redirect
      Get.to(()=>ResetPasswordScreen(email:email.text.trim() ,));
    }catch(e){
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());


    }
  }

  resendPasswordRestEmail(String email)async{ try{
    //start loader
    TFullScreenLoader.openLoadingDialog('Processing your request...', TImage.animation);

    //check internet connectivity
    final isConnected=await NetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      return;
    }

    //send email to reset password
    await AuthenticationRepository.instance.sendPasswordRestEmail(email);
    //remove loader
    TFullScreenLoader.stopLoading();
    //show success screen
    TLoaders.successSnackBar(title: 'Email Sent',message: 'Email Link sent to Rest your password'.tr);

  }catch(e){
    //remove loader
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());


  }
  }

}