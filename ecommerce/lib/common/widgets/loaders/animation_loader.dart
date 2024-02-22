import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

/// A widget for displaying an animated loading indicator with optional text and action button
class TAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the TAnimationLoaderWidget
  ///
  /// Parameters:
  /// -text: the text to displayed below the animation
  /// -animation: the path to Lottie animation file
  /// -showAction:whether to show an action button below the text
  /// -actionText:the text to be displayed on the action button
  /// -onActionPressed:callback function to be executed when the action button is pressed
  const TAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(animation,
                width: MediaQuery.of(context).size.width *
                    0.8,
            fit:BoxFit.contain ),
          ), //display lottie animation
          const SizedBox(height: TSizes.defaultSpace,),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace,),
          showAction
              ? Flexible(
                child: OutlinedButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.light),
                    )),
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}

///
