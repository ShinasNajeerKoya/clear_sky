import 'dart:ui';

import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return BlocProvider(
      create: (context) => WeatherBloc()..add(GetCityNameEvent("udupi")),
      child: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.weatherStatus == WeatherStatus.loading) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Weather app using bloc - Loading"),
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: Center(
                child: Text("Loading"),
              ),
            );
          }
          if (state.weatherStatus == WeatherStatus.loaded) {
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
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: Colors.transparent,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomContainer(
                                margin: EdgeInsets.only(
                                  top: SizeConfig.getHeight(15),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(12)),
                                height: SizeConfig.getHeight(55),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          hintText: "Search Weather...",
                                          hintStyle: TextStyle(color: Colors.grey.shade400),
                                          border: InputBorder.none,
                                        ),
                                        onSubmitted: (inputValue) {
                                          // _searchRecipe(inputValue);
                                        },
                                      ),
                                    ),
                                    Icon(
                                      CupertinoIcons.map_pin,
                                      size: SizeConfig.getIconSize(22),
                                      color: Colors.grey.shade700,
                                    ),
                                  ],
                                ),
                              ),
                              CustomSizedBox(),
                              CustomContainer(
                                height: height * 0.25,
                              ),
                              CustomSizedBox(),
                              Container(
                                height: height * 0.1,
                                color: Colors.red.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomContainer(
                                      width: (width / 2) - 25,
                                    ),
                                    Container(
                                      width: (width / 2) - 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomSizedBox(),
                              Container(
                                height: height * 0.15,
                                width: width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Container(
                                    width: width / 5,
                                    margin: EdgeInsets.only(right: SizeConfig.getWidth(10)),
                                    height: height * 0.1,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(SizeConfig.getRadius(15))),
                                  ),
                                ),
                              ),
                              CustomSizedBox(),
                              CustomContainer(
                                height: height * 0.15,
                                width: width,
                              ),
                              CustomSizedBox(),
                              CustomContainer(
                                height: height * 0.4,
                              ),
                              CustomSizedBox(),
                              CustomContainer(
                                height: height * 0.225,
                              ),
                              CustomSizedBox(),
                            ],
                          ),
                        ),
                        // child: Stack(
                        //   children: [
                        //     SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           Container(
                        //             padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                        //             child: Column(
                        //               children: [
                        //
                        //               ],
                        //             ),
                        //           ),
                        //           SizedBox(height: height * 0.4),
                        //           // Space for the content that appears above the bottom widgets
                        //         ],
                        //       ),
                        //     ),
                        //     Positioned(
                        //       bottom: height * 0.4,
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: SizeConfig.getWidth(20),
                        //           vertical: SizeConfig.getHeight(10),
                        //         ),
                        //         width: width,
                        //         // color: Colors.grey.withOpacity(0.2),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             IconTextRow(
                        //               icon: CupertinoIcons.house,
                        //               iconSize: SizeConfig.getIconSize(20),
                        //               text: "Place name",
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //             Text(
                        //               "22°C",
                        //               style: TextStyle(
                        //                 fontSize: SizeConfig.getFontSize(90),
                        //                 fontWeight: FontWeight.bold,
                        //                 letterSpacing: 5,
                        //               ),
                        //             ),
                        //             IconTextRow(
                        //               icon: CupertinoIcons.thermometer,
                        //               iconSize: SizeConfig.getIconSize(20),
                        //               text: "Feels like : 18°C",
                        //               fontSize: SizeConfig.getFontSize(23),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       bottom: 0,
                        //       child: Container(
                        //         width: width,
                        //         height: height * 0.4,
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(20)),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(
                        //               SizeConfig.getRadius(20),
                        //             ),
                        //             topRight: Radius.circular(
                        //               SizeConfig.getRadius(20),
                        //             ),
                        //           ),
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             DetailsContainerRow(
                        //               width: width,
                        //               height: height,
                        //               icon1: CupertinoIcons.drop,
                        //               title1: "Humidity",
                        //               value1: "46%",
                        //               icon2: CupertinoIcons.wind,
                        //               title2: "Wind",
                        //               value2: "29 km/h",
                        //             ),
                        //             Divider(
                        //               thickness: 1,
                        //             ),
                        //             DetailsContainerRow(
                        //               width: width,
                        //               height: height,
                        //               icon1: CupertinoIcons.smoke,
                        //               title1: "Humidity",
                        //               value1: "2%",
                        //               icon2: CupertinoIcons.sun_min,
                        //               title2: "Humidity",
                        //               value2: "6 of 10",
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       bottom: 0,
                        //       left: 0,
                        //       right: 0,
                        //       child: Container(
                        //         height: height * 0.09,
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(10)),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(
                        //               SizeConfig.getRadius(10),
                        //             ),
                        //             topRight: Radius.circular(
                        //               SizeConfig.getRadius(10),
                        //             ),
                        //           ),
                        //           boxShadow: [
                        //             BoxShadow(
                        //                 offset: Offset(0, -1),
                        //                 blurRadius: 10,
                        //                 spreadRadius: 0,
                        //                 color: Colors.grey.shade400),
                        //           ],
                        //         ),
                        //         child: GNav(
                        //           activeColor: Colors.teal.shade900,
                        //           color: Colors.grey,
                        //           gap: 5,
                        //           tabs: [
                        //             GButton(
                        //               backgroundColor: Colors.teal.withOpacity(0.1),
                        //               padding: EdgeInsets.all(SizeConfig.getHeight(15)),
                        //               icon: CupertinoIcons.home,
                        //               iconSize: SizeConfig.getIconSize(20),
                        //               text: "Home",
                        //             ),
                        //             GButton(
                        //               backgroundColor: Colors.teal.withOpacity(0.1),
                        //               padding: EdgeInsets.all(SizeConfig.getHeight(15)),
                        //               icon: CupertinoIcons.search,
                        //               iconSize: SizeConfig.getIconSize(20),
                        //               text: "Search",
                        //             ),
                        //             GButton(
                        //               backgroundColor: Colors.teal.withOpacity(0.1),
                        //               padding: EdgeInsets.all(SizeConfig.getHeight(15)),
                        //               icon: CupertinoIcons.antenna_radiowaves_left_right,
                        //               text: "Popular",
                        //               iconSize: SizeConfig.getIconSize(20),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          if (state.weatherStatus == WeatherStatus.error) {
            return Scaffold(
              body: Center(
                child: Text(state.error),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Weather app using bloc - null"),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          );
        },
      ),
    );
  }
}

