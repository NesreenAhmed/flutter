import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboardding_skip.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommerce/utils/device/device_utilty.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboard_dot_navigator.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_nextbutton.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //horizontal scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: TImage.onBoardingImage1,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1),
              OnBoardingPage(
                  image: TImage.onBoardingImage2,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2),
              OnBoardingPage(
                  image: TImage.onBoardingImage3,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3),
            ],
          ),
          //skip button
          const OnBoardingSkip(),
          //dot Navigator
          const OnBoardingNavigation(),
          //circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

