import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Color? backgroundColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyText({
    super.key,
    required this.text,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
    this.fontColor,
    this.letterSpacing,
    this.wordSpacing,
    this.fontSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? SizeConfig.getFontSize(15.0),
        fontWeight: fontWeight ?? FontWeight.w200,
        color: fontColor ?? Colors.white,
        letterSpacing: letterSpacing ?? 0.0,
        wordSpacing: wordSpacing ?? 0.0,
        backgroundColor: backgroundColor ?? Colors.transparent,
      ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
    );
  }
}
