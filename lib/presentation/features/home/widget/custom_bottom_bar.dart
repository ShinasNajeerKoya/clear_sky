import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomBar extends StatelessWidget {
  final double width;
  final int selectedIndex;
  final void Function(int)? onTabChange;

  const CustomBottomBar({super.key, required this.width, required this.selectedIndex, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: SizeConfig.getHeight(60),
      width: width,
      color: Colors.white.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(7)),
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.getWidth(15),
        vertical: SizeConfig.getHeight(28),
      ),
      child: GNav(
        tabBorderRadius: SizeConfig.getWidth(10),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getWidth(10),
          vertical: SizeConfig.getHeight(13),
        ),
        color: Colors.black,
        tabBackgroundColor: const Color(0xffd7ff26),
        gap: SizeConfig.getWidth(8),
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        tabs: [
          GButton(
            icon: CupertinoIcons.home,
            iconSize: SizeConfig.getIconSize(20),
            text: "Home",
            textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
          ),
          GButton(
            icon: CupertinoIcons.bookmark,
            iconSize: SizeConfig.getIconSize(20),
            text: "Popular",
            textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
