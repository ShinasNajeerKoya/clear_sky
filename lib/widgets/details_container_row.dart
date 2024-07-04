import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_vertical_divider.dart';
import 'package:flutter/material.dart';

class DetailsContainerRow extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon1;
  final IconData icon2;
  final String title1;
  final String title2;
  final String value1;
  final String value2;

  const DetailsContainerRow({
    super.key,
    required this.width,
    required this.height,
    required this.icon1,
    required this.icon2,
    required this.title1,
    required this.title2,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsContainer(
          width: width,
          height: height,
          icon: icon1,
          title: title1,
          value: value1,
        ),
        CustomVerticalDivider(
          height: (height * 0.13),
        ),
        DetailsContainer(
          width: width,
          height: height,
          icon: icon2,
          title: title2,
          value: value2,
        ),
      ],
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String title;
  final String value;

  const DetailsContainer({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.4,
      // height: (height * 0.4 - 120) / 2,
      height: (height * 0.13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: SizeConfig.getIconSize(25),
          ),
          Text(
            title,
            style: TextStyle(fontSize: SizeConfig.getFontSize(14)),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.getFontSize(18)),
          )
        ],
      ),
    );
  }
}
