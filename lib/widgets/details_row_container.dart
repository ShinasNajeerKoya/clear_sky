import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DetailsRowContainer extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double? fontSize;
  final Color? titleColor;

  DetailsRowContainer({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.fontSize,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return CustomContainer(
      height: SizeConfig.getHeight(90),
      width: (width / 2) - 25,
      padding: EdgeInsets.only(
        left: SizeConfig.getHeight(15),
        right: SizeConfig.getHeight(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyText(
                text: title,
                fontSize: SizeConfig.getFontSize(15),
                color: titleColor ?? Colors.grey,
              ),
              MyText(
                text: value,
                fontSize: fontSize ?? SizeConfig.getFontSize(35),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Icon(
            icon,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
