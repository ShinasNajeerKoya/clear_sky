import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // Initialize SizeConfig

    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

    return Scaffold(
      body: BlocListener<BottomNavigationBloc, BottomNavigationState>(
        listener: (context, state) {
          if (state is NavigateToHomeState) {
            Navigator.popAndPushNamed(context, '/home', arguments: state.city);
          }
        },
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/bgs/clear_sky_bg_2.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.55),
                BlendMode.multiply,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text: "Weather",
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.getFontSize(65),
                    fontColor: Colors.white,
                  ),
                  // Add some space between the texts
                  MyText(
                    text: "On your",
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.getFontSize(65),
                    fontColor: Colors.grey,
                  ),
                  MyText(
                    text: "Terms",
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.getFontSize(65),
                    fontColor: Colors.grey,
                  ),
                  SizedBox(height: SizeConfig.getHeight(15)),
                  Row(
                    mainAxisSize: MainAxisSize.min, // Avoid extra space
                    children: [
                      MyText(
                        text: "Your pocket ",
                        fontSize: SizeConfig.getFontSize(25),
                        fontWeight: FontWeight.w100,
                        fontColor: Colors.grey,
                      ),
                      MyText(
                        text: "weather ",
                        fontSize: SizeConfig.getFontSize(25),
                        fontWeight: FontWeight.w400,
                      ),
                      MyText(
                        text: "guide!",
                        fontSize: SizeConfig.getFontSize(25),
                        fontWeight: FontWeight.w100,
                        fontColor: Colors.grey,
                      ),
                    ],
                  ),

                  SizedBox(height: SizeConfig.getHeight(40)),
                  CustomContainer(
                    onTap: () {
                      context.read<BottomNavigationBloc>().add(const NavigateToHomeEvent(city: "Sydney"));
                    },
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(20)),
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(100)),
                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(16)),
                    color: const Color(0xff0d5015),
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
                      fontSize: SizeConfig.getFontSize(20),
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: SizeConfig.getWidth(2),
                    ),
                  ),
                  SizedBox(height: SizeConfig.getHeight(70)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
