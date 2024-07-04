import 'package:clear_sky/utils/size_configuation.dart';
import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  IconTextRow({
    super.key,
    required this.icon,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.iconSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final customIconSize = iconSize ?? SizeConfig.getIconSize(15);
    final customFontSize = fontSize ?? SizeConfig.getFontSize(18);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: customIconSize,
        ),
        SizedBox(
          width: SizeConfig.getWidth(5),
        ),
        Text(
          text,
          style: TextStyle(fontSize: customFontSize, fontWeight: fontWeight),
        ),
      ],
    );
  }
}
