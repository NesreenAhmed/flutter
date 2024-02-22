import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/data/respositories/user/user_repositry.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:ecommerce/features/personalization/screens/profile/widget/re_auth_user_login_form.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/network_manager.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController{
  static UserController get instance=>Get.find();

  final profileLoading=false.obs;
  Rx<UserModel> user=UserModel.empty().obs;

  final hidePassword=false.obs;
  final imageUploader=false.obs;
  final verifyEmail=TextEditingController();
  final verifyPassword=TextEditingController();
  final userRepository=Get.put(UserRepository());
  GlobalKey<FormState>reAuthFormKey=GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //fetch user record
  Future<void>fetchUserRecord()async{
    try{
      profileLoading.value=true;
      final user=await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value=false;
    }catch(e){
      user(UserModel.empty());
    }finally{
      profileLoading.value=false;
    }
  }

  //save user record from ant registration provider
  Future<void>saveUserRecord(UserCredential? userCredentials)async{
    try{
      ///First update Rx user and then check if user data is already stored.if not store new data
      await fetchUserRecord();
      ///if no record already stored
      if(user.value.id.isEmpty) {
        if (userCredentials != null) {
          //convert Name to first and last name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? '');
          final username = UserModel.generatedUsername(
              userCredentials.user!.displayName ?? '');

          //map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          //save user data
          await userRepository.saveUserRecord(user);
        }
      }

    }catch(e){
      TLoaders.warningSnackBar(
          title:'Data not saved',
        message: 'Something went wrong while saving your information.You can re-save your data in Profile',
      );
    }
  }

  ///Delete Account Warning
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
          onPressed: ()async=>deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red,side: const BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg),child: Text('Delete'),),
      ),
      cancel: OutlinedButton(
          onPressed: ()=>Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
      ),
    );
  }
  ///Delete User Account
  void deleteUserAccount()async{
    try{
      TFullScreenLoader.openLoadingDialog('Processing', TImage.animation);

      ///first re-auth user
      final auth=AuthenticationRepository.instance;
      final provider=auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        //re verify Email
        if(provider=='google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(()=>const LoginScreen());
        }else if(provider=='password'){
          TFullScreenLoader.stopLoading();
          Get.to(()=>const ReAuthLoginForm());
        }
      }
  }catch(e){
    TFullScreenLoader.stopLoading();
    TLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
  }
  }

  ///RE-Authenticate before deleting
  Future <void>reAuthenticateEmailAndPasswordUser()async{
    try{
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in... ', TImage.animation);

      //check Internet connectivity
      final isConnected=await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }
      if(!reAuthFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      //remover loader
      TFullScreenLoader.stopLoading();

      //redirect
      Get.offAll(()=>const LoginScreen());

    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
  ///upload profile picture
  uploadUserProfilePicture()async{
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploader.value=true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(title: 'Congratulations',message:'Your profile Image has been updated' );
      }
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: 'Something went wrong: $e');
    }finally{
      imageUploader.value=false;
    }

  }
}