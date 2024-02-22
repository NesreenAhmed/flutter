import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/common/styles/spacing_styles.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:ecommerce/common/widgets/social_button.dart';
import 'package:ecommerce/common/widgets/form_divider.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpaceStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const TLoginHeader(),
              const TLoginForm(),

              //Divider
              TFormDivider(diverText:TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwItem),
              //Footer
              const  TSocialButton()
            ],
          ),
        ),
      ),
    );
  }
}





