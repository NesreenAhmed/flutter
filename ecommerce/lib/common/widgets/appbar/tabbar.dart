import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/device/device_utilty.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/helper/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget{
  //if you want to add the background color to tabs you have to wrap them in material widget
  //to to that we need [PreferredSizeWidget] and that's why we created custom class
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark?TColors.black:TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable:true,
        indicatorColor: TColors.primary,
        labelColor: dark?TColors.white:TColors.primary,
        unselectedLabelColor: TColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
