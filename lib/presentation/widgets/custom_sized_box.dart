import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const CustomSizedBox({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? SizeConfig.getHeight(20),
      width: width ?? 0.0,
      child: child,
    );
  }
}
