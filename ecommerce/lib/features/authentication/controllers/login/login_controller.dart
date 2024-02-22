import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helper/network_manager.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  ///variables
  final rememberMe=false.obs;
  final hidePassword=true.obs;
  final localStorage=GetStorage();
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState>loginFormKey=GlobalKey<FormState>();
  final userController=Get.put(UserController());


  @override
  void onInit() {
    //email.text=localStorage.read('REMEMBER_ME_EMAIL');
    //print(localStorage.read('REMEMBER_ME_EMAIL'));
    //password.text=localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();

      // Now you can safely access localStorage
      email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
      password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
      print(localStorage.read('REMEMBER_ME_EMAIL'));

  }

  ///--Email and password SignIn
  Future<void>emailAndPasswordSignIn()async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImage.animation);

      //check internet connectivity
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //Login user using Email and password Authentication
      final userCredentials=await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }

  }

  ///Google sign in auth
  Future<void>googleSignIn() async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in... ', TImage.animation);

      //check Internet connectivity
      final isConnected=await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      //google auth
      final userCredentials=await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      //remover loader
      TFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
}