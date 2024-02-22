import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/data/respositories/user/user_repositry.dart';
import 'package:ecommerce/features/authentication/screens/sginup/verify_email.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helper/network_manager.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignupController extends GetxController{

  static SignupController get instance=>Get.find();

  //variable
  final hidePassword=true.obs;
  final privacyPolicy=true.obs;
  final email=TextEditingController();//controller for email input
  final firstname=TextEditingController();//controller for first name input
  final lastname=TextEditingController();//controller for last name input
  final username=TextEditingController();//controller for username input
  final password=TextEditingController();//controller for password input
  final phoneNumber=TextEditingController();//controller for phone number input
  GlobalKey<FormState> signupFormKey=GlobalKey<FormState>();//form key for form validation

//signup
void signup() async{
  try{
    //start loading
    TFullScreenLoader.openLoadingDialog('We are processing your information...', TImage.animation);
    //check internet connection
    final isConnected=await NetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      return ;
    }
    //from validation
    if(!signupFormKey.currentState!.validate()){
      TFullScreenLoader.stopLoading();
      return ;
    }

    //privacy policy check
    if(!privacyPolicy.value){
      TLoaders.warningSnackBar(title: 'Accept privacy Policy',message: 'In order to create account, you must have read and accept the Privacy Policy & Terms of use');
      return ;
    }

    //register user in the firebase auth and save user data in the firebase
    final userCredential=await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text, password.text.trim());

    //save auth user data in the firebase Firestore
      final newUser=UserModel(
          id: userCredential.user!.uid,
          firstName: firstname.text.trim(),
          lastName: lastname.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
      );
    final userRepository=Get.put(UserRepository());
    userRepository.saveUserRecord(newUser);

    //show success message
    TLoaders.successSnackBar(title: 'Congratulations',message: 'Your account has been created! Verify email to continue.');

    //move to verify email
    Get.to(()=>VerifyEmailScreen(email:email.text.trim(),));

  }catch(e){
    //show some generic error to the user
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
  }
}

}