import 'dart:developer';

import 'package:clear_sky/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/screens/home_screen.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/utils/utils.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularScreenBody extends StatefulWidget {
  final double height;
  final double width;

  const PopularScreenBody({super.key, required this.height, required this.width});

  @override
  State<PopularScreenBody> createState() => _PopularScreenBodyState();
}

class _PopularScreenBodyState extends State<PopularScreenBody> {
  List<WeatherBloc> weatherBlocs = [];

  @override
  void initState() {
    super.initState();
    // countries data is from util page
    for (var country in countries) {
      WeatherBloc weatherBloc = WeatherBloc();
      weatherBloc.add(GetCityNameEvent(country['searchName']!));
      weatherBlocs.add(weatherBloc);
    }
  }

  @override
  void dispose() {
    for (var weatherBloc in weatherBlocs) {
      weatherBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Stack(
      children: [
        SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CustomContainer(
                height: SizeConfig.getHeight(70),
                width: widget.width,
                color: Colors.transparent,
              ),
              SizedBox(height: SizeConfig.getHeight(15)),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                itemCount: countries.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var country = countries[index];
                  return CustomContainer(
                    onTap: () {
                      log("ListView container $index is pressed");
                      log("can pass query of container ${country['name']!} here");


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(query: country['searchName']!),
                        ),
                      );
                      
                      // Navigator.pushNamed(
                      //   context,
                      //   '/home',
                      // );
                      // context.read<WeatherBloc>().add(
                      //       GetCityNameEvent(
                      //         country['searchName']!,
                      //         // pageRoute: Navigator.pushNamed(context, '/search', arguments: inputValue),
                      //       ),
                      //     );

                      // Navigator.popAndPushNamed(context.read<WeatherBloc>().add(
                      //   FetchSearchResultsEvent(
                      //     searchValue: country['searchName']!,
                      //   ),
                      // ));

                      // context.read<WeatherBloc>().add(
                      //       FetchSearchResultsEvent(
                      //         pageRoute: Navigator.pushNamed(context, '/search',
                      //             arguments: country['searchName']!),
                      //       ),
                      //     );
                    },
                    height: SizeConfig.getHeight(180),
                    width: widget.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getWidth(20),
                      vertical: SizeConfig.getHeight(15),
                    ),
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                    margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                    child: BlocProvider.value(
                      value: weatherBlocs[index],
                      child: BlocConsumer<WeatherBloc, WeatherState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state.isLoading) {
                            return Center(
                                child: MyText(
                              text: "Loading values...",
                            ));
                          } else if (state.weatherData != null) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomContainer(
                                        color: Colors.transparent,
                                        height: SizeConfig.getHeight(80),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomContainer(
                                                  height: SizeConfig.getHeight(24),
                                                  width: SizeConfig.getWidth(35),
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                      image: AssetImage(country['flag']!), fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(SizeConfig.getRadius(5)),
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.getWidth(10),
                                                ),
                                                Flexible(
                                                  child: MyText(
                                                    text: country['name']!,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig.getFontSize(26),
                                                    overflow: TextOverflow.ellipsis,
                                                    letterSpacing: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                            MyText(
                                              text: CurrentTimeConversion.formatSecondsToReadableTime(
                                                  state.weatherData!.timezone!),
                                              fontSize: SizeConfig.getFontSize(20),
                                              letterSpacing: 4,
                                            )
                                          ],
                                        ),
                                      ),
                                      MyText(text: "Feels like : ${state.weatherData!.main!.feelsLike}°C")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomContainer(
                                        height: SizeConfig.getHeight(80),
                                        width: SizeConfig.getHeight(80),
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                weatherIcons[state.weatherData!.weather![0].icon] ??
                                                    'assets/weather_icons/weather_error.png')),
                                      ),
                                      MyText(
                                        text: "${state.weatherData!.main!.temp}°C",
                                        fontSize: SizeConfig.getFontSize(25),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      MyText(
                                        text: "${state.weatherData!.weather![0].description}",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else if (state.error != null) {
                            return Center(
                              child: MyText(text: state.error!),
                            );
                          } else {
                            return Center(
                              child: MyText(text: "Unknown error"),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 57,
          left: 15,
          right: 15,
          child: CustomContainer(
            height: SizeConfig.getHeight(50),
            width: widget.width,
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
            child: MyText(
              text: "Popular Places",
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontColor: Colors.black,
            ),
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: BlocConsumer<BottomNavigationBloc, int>(
        //     listener: (context, state) {
        //       if (state == 0) {
        //         Navigator.pushReplacementNamed(context, '/home');
        //       } else if (state == 1) {
        //         Navigator.pushReplacementNamed(context, '/popular');
        //       }
        //     },
        //     builder: (context, state) {
        //       return CustomContainer(
        //         height: SizeConfig.getHeight(60),
        //         width: width,
        //         color: Colors.white.withOpacity(0.2),
        //         padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(7)),
        //         margin: EdgeInsets.symmetric(
        //           horizontal: SizeConfig.getWidth(15),
        //           vertical: SizeConfig.getHeight(28),
        //         ),
        //         child: GNav(
        //           tabBorderRadius: SizeConfig.getWidth(10),
        //           padding: EdgeInsets.symmetric(
        //             horizontal: SizeConfig.getWidth(10),
        //             vertical: SizeConfig.getHeight(13),
        //           ),
        //           color: Colors.black,
        //           tabBackgroundColor: Color(0xffd7ff26),
        //           gap: 8,
        //           selectedIndex: state,
        //           onTabChange: (index) {
        //             // i am getting error of setstate after dispose, so trying to mount it to the widget tree
        //             if (index == 0) {
        //               context.read<BottomNavigationBloc>().add(BottomNavigateToHomeEvent());
        //               Navigator.pushReplacementNamed(context, '/home');
        //             } else if (index == 1) {
        //               context.read<BottomNavigationBloc>().add(BottomNavigateToPopularEvent());
        //               Navigator.pushReplacementNamed(context, '/popular');
        //             }
        //           },
        //           tabs: [
        //             GButton(
        //               icon: CupertinoIcons.home,
        //               iconSize: 20,
        //               text: "Home",
        //               textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //             ),
        //             GButton(
        //               icon: CupertinoIcons.bookmark,
        //               iconSize: 20,
        //               text: "Popular",
        //               textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
