import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';

// class DetailsContainerRow extends StatelessWidget {
//   final double width;
//   final double height;
//   final IconData icon1;
//   final IconData icon2;
//   final String title1;
//   final String title2;
//   final String value1;
//   final String value2;
//
//   const DetailsContainerRow({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.icon1,
//     required this.icon2,
//     required this.title1,
//     required this.title2,
//     required this.value1,
//     required this.value2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         DetailsContainer(
//           width: width,
//           height: height,
//           icon: icon1,
//           title: title1,
//           value: value1,
//         ),
//         CustomVerticalDivider(
//           height: (height * 0.13),
//         ),
//         DetailsContainer(
//           width: width,
//           height: height,
//           icon: icon2,
//           title: title2,
//           value: value2,
//         ),
//       ],
//     );
//   }
// }

class DetailsRowContainer extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double? fontSize;

  DetailsRowContainer({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return CustomContainer(
      height: SizeConfig.getHeight(90),
      width: (width / 2) - 25,
      padding: EdgeInsets.only(
        left: SizeConfig.getHeight(15),
        right: SizeConfig.getHeight(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyText(
                text: title,
                fontSize: SizeConfig.getFontSize(15),
              ),
              MyText(
                text: value,
                fontSize: fontSize ?? SizeConfig.getFontSize(35),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Icon(
            icon,
            size: 32,
          )
        ],
      ),
    );
  }
}
