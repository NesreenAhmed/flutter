import 'package:ecommerce/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants/colors.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.diverText,
  });

  final String diverText;
  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkerGrey : TColors.softGrey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          diverText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkerGrey : TColors.softGrey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}