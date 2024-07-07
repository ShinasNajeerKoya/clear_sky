import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class DetailsRowContainer extends StatelessWidget {
  final String title;
  final String value;
  final String iconImage;
  final double? fontSize;
  final Color? titleColor;
  final double? letterSpacing;

  const DetailsRowContainer({
    super.key,
    required this.title,
    required this.value,
    required this.iconImage,
    this.fontSize,
    this.titleColor,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final width = SizeConfig.screenWidth;
    return CustomContainer(
      height: SizeConfig.getHeight(90),
      width: (width / 2) - SizeConfig.getHeight(25),
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
                fontColor: titleColor ?? Colors.grey,
              ),
              MyText(
                text: value,
                fontSize: fontSize ?? SizeConfig.getFontSize(35),
                fontWeight: FontWeight.bold,
                letterSpacing: letterSpacing,
              ),
            ],
          ),
          CustomContainer(
            color: Colors.transparent,
            borderRadius: BorderRadius.zero,
            height: SizeConfig.getHeight(32),
            width: SizeConfig.getWidth(32),
            child: Image.asset(iconImage),
          ),
        ],
      ),
    );
  }
}
