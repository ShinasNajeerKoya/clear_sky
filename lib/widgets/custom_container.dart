import 'package:clear_sky/utils/size_configuation.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxShadow? boxShadow;
  final BoxBorder? border;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.child,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      constraints: BoxConstraints(
        minHeight: height ?? 0.0,
        minWidth: width ?? 0.0,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(SizeConfig.getRadius(15)),
        color: color ?? Colors.white.withOpacity(0.85),
        boxShadow: boxShadow != null ? [boxShadow!] : [],
        border: border,
      ),
      child: child,
    );
  }
}
