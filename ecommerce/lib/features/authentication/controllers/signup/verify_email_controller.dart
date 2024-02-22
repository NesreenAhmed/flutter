import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/data/respositories/repositories_auth/auth_repository.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///Send Email whenever verify screen appears and set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email send',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

  ///Timer to automatically redirect an Email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: TImage.staticSuccessIllustration,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    }
    );
  }

  /// Manually check if Email verified
  checkEmailVerificationStatus()async{
    final currentUser=FirebaseAuth.instance.currentUser;
    if(currentUser!=null&&currentUser.emailVerified){
      Get.off(() => SuccessScreen(
          image: TImage.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () =>
              AuthenticationRepository.instance.screenRedirect()));

    }
  }
}
