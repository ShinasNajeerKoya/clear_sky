import 'dart:ui';

import 'package:clear_sky/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/bloc/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:clear_sky/bloc/search_bloc/search_bloc.dart';
import 'package:clear_sky/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/utils/utils.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:clear_sky/widgets/custom_vertical_divider.dart';
import 'package:clear_sky/widgets/details_row_container.dart';
import 'package:clear_sky/widgets/my_circular_slider.dart';
import 'package:clear_sky/widgets/my_icon_text_row.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:clear_sky/widgets/sunrise_set_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false, // to prevent the screen move up with the keyboard
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              image: const DecorationImage(
                image: AssetImage("assets/bgs/forest_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomSizedBox(
                          height: SizeConfig.getHeight(50),
                        ),
                        CustomContainer(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(12)),
                          height: SizeConfig.getHeight(55),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search Weather...",
                                    hintStyle: TextStyle(color: Colors.grey.shade400),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (inputValue) {
                                    context
                                        .read<SearchBloc>()
                                        .add(FetchSearchResultsEvent(query: inputValue));
                                    Navigator.pushNamed(context, '/search', arguments: inputValue);
                                  },
                                ),
                              ),
                              Icon(
                                CupertinoIcons.map_pin,
                                size: SizeConfig.getIconSize(22),
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                        const CustomSizedBox(),
                        IntrinsicHeight(
                          child: BlocProvider(
                            create: (context) => WeatherBloc()..add(const GetCityNameEvent("italy")),
                            child: BlocConsumer<WeatherBloc, WeatherState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.weatherData != null) {
                                  return Column(
                                    children: [
                                      CustomContainer(
                                        height: SizeConfig.getHeight(250),
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.getHeight(18),
                                          bottom: SizeConfig.getHeight(5),
                                          left: SizeConfig.getHeight(20),
                                          right: SizeConfig.getHeight(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSizedBox(
                                              height: SizeConfig.getHeight(130),
                                              width: width,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomSizedBox(
                                                            height: SizeConfig.getHeight(10),
                                                          ),
                                                          MyIconTextRow(
                                                            icon: CupertinoIcons.calendar,
                                                            iconSize: 14,
                                                            details: DateTimeConversion.formatUnixTimestamp(
                                                                state.weatherData!.sys!.sunset!),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w100,
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig.getHeight(8),
                                                          ),
                                                          MyIconTextRow(
                                                            icon: CupertinoIcons.location,
                                                            iconSize: 14,
                                                            details: state.weatherData!.name.toString(),
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w100,
                                                          ),
                                                        ],
                                                      ),
                                                      MyIconTextRow(
                                                        icon: CupertinoIcons.cloud,
                                                        iconSize: 18,
                                                        details:
                                                            "${state.weatherData!.weather![0].description}",
                                                        fontSize: 22,
                                                        fontColor: Colors.grey.shade500,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                  CustomSizedBox(
                                                    height: SizeConfig.getHeight(100),
                                                    width: SizeConfig.getHeight(100),
                                                    child: Image.asset(
                                                        weatherIcons[state.weatherData!.weather![0].icon] ??
                                                            'assets/weather_icons/weather_error.png'),
                                                  )
                                                ],
                                              ),
                                            ),
                                            MyText(
                                              text: "${state.weatherData!.main!.temp}°C",
                                              fontSize: 65,
                                              fontWeight: FontWeight.w700,
                                            )
                                          ],
                                        ),
                                      ),
                                      const CustomSizedBox(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DetailsRowContainer(
                                            title: "Time Zone",
                                            value: CurrentTimeConversion.formatSecondsToReadableTime(
                                                state.weatherData!.timezone!),
                                            iconImage: "assets/details_icons/time.png",
                                            fontSize: 25,
                                            letterSpacing: 1,
                                          ),
                                          DetailsRowContainer(
                                            title: "Wind",
                                            value: "${state.weatherData!.wind!.speed} km/h",
                                            iconImage: "assets/details_icons/wind.png",
                                            fontSize: 20,
                                            letterSpacing: 0.5,
                                          ),
                                        ],
                                      ),
                                      const CustomSizedBox(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DetailsRowContainer(
                                            title: "Minimum",
                                            value: "${state.weatherData!.main!.tempMin}°C",
                                            iconImage: "assets/details_icons/cold.png",
                                            fontSize: 25,
                                            letterSpacing: 1,
                                          ),
                                          DetailsRowContainer(
                                            title: "Maximum",
                                            value: "${state.weatherData!.main!.tempMax}°C",
                                            iconImage: "assets/details_icons/hot.png",
                                            fontSize: 25,
                                            letterSpacing: 1,
                                          ),
                                        ],
                                      ),
                                      const CustomSizedBox(),
                                      CustomContainer(
                                        padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(20)),
                                        height: SizeConfig.getHeight(150),
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            SunRiseSetColumn(
                                              title: "Sunrise",
                                              time: SunRiseToSetTimeConversion.formatUnixTimestamp(
                                                  state.weatherData!.sys!.sunrise!),
                                              imageAddress: "assets/sun/sunrise.png",
                                            ),
                                            const CustomVerticalDivider(),
                                            SunRiseSetColumn(
                                              title: "Sunset",
                                              time: SunRiseToSetTimeConversion.formatUnixTimestamp(
                                                  state.weatherData!.sys!.sunset!),
                                              imageAddress: "assets/sun/sunset.png",
                                            ),
                                          ],
                                        ),
                                      ),
                                      const CustomSizedBox(),
                                      CustomContainer(
                                        padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(15)),
                                        height: SizeConfig.getHeight(200),
                                        width: width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const MyText(
                                              text: "Comfort Level",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            MyCircularSlider(
                                              state: state,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const CustomSizedBox(),
                                    ],
                                  );
                                } else if (state.error != null) {
                                  return CustomContainer(
                                    height: SizeConfig.getHeight(715),
                                    width: width,
                                    image: const DecorationImage(
                                        image: AssetImage("assets/errors/home_error.png"),
                                        fit: BoxFit.fitWidth),
                                  );
                                } else {
                                  return CustomContainer(
                                    height: SizeConfig.getHeight(715),
                                    width: width,
                                    image: const DecorationImage(
                                        image: AssetImage("assets/errors/home_error.png"),
                                        fit: BoxFit.fitWidth),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<BottomNavigationBloc, int>(
              builder: (context, state) {
                return CustomContainer(
                  height: SizeConfig.getHeight(60),
                  width: width,
                  color: Colors.white.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(7)),
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getWidth(15),
                    vertical: SizeConfig.getHeight(28),
                  ),
                  child: GNav(
                    tabBorderRadius: SizeConfig.getWidth(10),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.getWidth(10),
                      vertical: SizeConfig.getHeight(13),
                    ),
                    color: Colors.black,
                    tabBackgroundColor: Color(0xffd7ff26),
                    gap: 8,
                    selectedIndex: state,
                    onTabChange: (index) {
                      if (index == 0) {
                        context.read<BottomNavigationBloc>().add(BottomNavigateToHomeEvent());
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (index == 1) {
                        context.read<BottomNavigationBloc>().add(BottomNavigateToPopularEvent());
                        Navigator.pushReplacementNamed(context, '/popular');
                      }
                    },
                    tabs: [
                      GButton(
                        icon: CupertinoIcons.home,
                        iconSize: 20,
                        text: "Home",
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GButton(
                        icon: CupertinoIcons.bookmark,
                        iconSize: 20,
                        text: "Popular",
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
