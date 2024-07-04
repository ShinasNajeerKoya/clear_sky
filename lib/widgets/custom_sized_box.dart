import 'package:clear_sky/utils/size_configuation.dart';
import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;

  const CustomSizedBox({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? SizeConfig.getHeight(20),
      width: width ?? 0.0,
    );
  }
}
