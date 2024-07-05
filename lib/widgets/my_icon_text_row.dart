import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyIconTextRow extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double fontSize;
  final String details;
  final FontWeight? fontWeight;

  const MyIconTextRow({
    super.key,
    required this.icon,
    required this.details,
    required this.iconSize,
    required this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        SizedBox(
          width: SizeConfig.getWidth(5),
        ),
        MyText(
          text: details,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ],
    );
  }
}