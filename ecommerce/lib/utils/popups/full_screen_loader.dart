import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A utility class for managing a full screen loading dialog
class TFullScreenLoader{
  ///open a full screen loading dialog with a given text and animation
  ///this method doesn't return anything

  ///parameters:
  /// -text:the text to be displayed in the loading dialog
  /// -animation: the Lottie animation to be shown.

  static void openLoadingDialog(String text,String animation){
    showDialog(
        context: Get.overlayContext!,//use get.overlaycontext for overlay dialogs
        barrierDismissible: false,//the dialog can't be dismissed by tapping outside it
        builder: (_)=>PopScope(
            canPop: false,//disable popping with the back button
            child: Container(
              color: THelperFunctions.isDarkMode(Get.context!)?TColors.dark:TColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20,),//adjust the spacing as needed
                  Flexible(child: TAnimationLoaderWidget(text: text, animation: animation)),
                ],
              ),
            )
        )
    );
  }
/// stop the currently open loading dialog
/// this method doesn't return anything
static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();//close the dialog
}
}
