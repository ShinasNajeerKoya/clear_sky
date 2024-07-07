import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class MyIconTextRow extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double fontSize;
  final String details;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyIconTextRow({
    super.key,
    required this.icon,
    required this.details,
    required this.iconSize,
    required this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
        SizedBox(
          width: SizeConfig.getWidth(6),
        ),
        CustomContainer(
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          width: SizeConfig.getWidth(190),
          child: MyText(
            text: details,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontColor: fontColor,
          ),
        ),
      ],
    );
  }
}
