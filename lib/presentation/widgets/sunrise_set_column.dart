import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';

class SunRiseSetColumn extends StatelessWidget {
  final String time;
  final String title;
  final String imageAddress;

  const SunRiseSetColumn({
    super.key,
    required this.time,
    required this.title,
    required this.imageAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: time,
          fontWeight: FontWeight.w600,
          fontSize: SizeConfig.getFontSize(23),
        ),
        Container(
          height: SizeConfig.getHeight(50),
          width: SizeConfig.getHeight(50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imageAddress),
            ),
          ),
        ),
        MyText(
          text: title,
          fontSize: SizeConfig.getFontSize(13),
        ),
      ],
    );
  }
}
