import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double height;

  const CustomVerticalDivider({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig.getWidth(0.2),
      height: height,
      color: Colors.grey.shade400,
    );
  }
}
