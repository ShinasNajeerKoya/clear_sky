import 'dart:ui';

import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class PopularPlaceWeatherWidget extends StatelessWidget {
  const PopularPlaceWeatherWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents the bottom widgets from moving up with the keyboard
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          image: DecorationImage(
            image: AssetImage("assets/bgs/forest_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomContainer(
                          height: height * 0.06,
                          width: height * 0.06,
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                        ),
                        Expanded(
                          child: CustomContainer(
                            height: height * 0.06,
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                            margin: EdgeInsets.only(left: SizeConfig.getWidth(15)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CustomContainer(
                          height: height * 0.2,
                          width: width,
                          borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                          margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
