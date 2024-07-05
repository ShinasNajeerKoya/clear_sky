import 'package:clear_sky/utils/size_configuation.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? color;
  final Alignment? alignment;
  final BorderRadiusGeometry? borderRadius;
  final BoxShadow? boxShadow;
  final BoxBorder? border;
  final DecorationImage? image;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.child,
    this.color,
    this.alignment,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        alignment: alignment ?? Alignment.center,
        constraints: BoxConstraints(
          minHeight: height ?? 0.0,
          minWidth: width ?? 0.0,
        ),
        decoration: BoxDecoration(
          color: color ?? Colors.black.withOpacity(0.8),
          boxShadow: boxShadow != null ? [boxShadow!] : [],
          border: border,
          borderRadius: borderRadius ?? BorderRadius.circular(SizeConfig.getRadius(15)),
          image: image,
        ),
        child: child,
      ),
    );
  }
}
