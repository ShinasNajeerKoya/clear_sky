import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;

  final Color? color;
  final Color? backgroundColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyText({
    Key? key,
    required this.text,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.fontSize,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 15.0,
        fontWeight: fontWeight ?? FontWeight.w200,
        color: color ?? Colors.white,
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
