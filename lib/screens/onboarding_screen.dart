import 'package:clear_sky/screens/home_screen.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/bgs/forest_bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.55),
              BlendMode.multiply,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText(
              text: "Cooking",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              fontColor: Colors.grey,
            ),
            // Add some space between the texts
            MyText(
              text: "Like a",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              fontColor: Colors.grey,
            ),
            MyText(
              text: "Chef",
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.getFontSize(65),
              fontColor: Colors.grey,
            ),
            SizedBox(height: SizeConfig.getHeight(15)),
            MyText(
              text: "Is a Piece of Cake!",
              fontSize: SizeConfig.getFontSize(25),
              fontWeight: FontWeight.w100,
              fontColor: Colors.grey,
            ),
            SizedBox(height: SizeConfig.getHeight(40)),
            CustomContainer(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              height: SizeConfig.getHeight(60),
              width: SizeConfig.getWidth(190),
              borderRadius: BorderRadius.circular(SizeConfig.getRadius(16)),
              color: Color(0xff000000),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade900,
                  offset: const Offset(0.0, 10.0),
                  blurRadius: 10.0,
                  spreadRadius: -5.0,
                ),
              ],
              child: MyText(
                text: "Get Started",
                fontSize: SizeConfig.getFontSize(18),
                fontColor: Colors.grey,
              ),
            ),
            SizedBox(height: SizeConfig.getHeight(70)),
          ],
        ),
      ),
    );
  }
}
