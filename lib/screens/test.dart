import 'package:clear_sky/utils/size_configuation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;

    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: SizeConfig.getHeight(100),
                width: SizeConfig.getWidth(200),
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Dynamic Size Example',
                    style: TextStyle(
                      fontSize: SizeConfig.getFontSize(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.getHeight(20)),
              Container(
                height: SizeConfig.getHeight(50),
                width: SizeConfig.getWidth(150),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Another Example',
                    style: TextStyle(
                      fontSize: SizeConfig.getFontSize(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
