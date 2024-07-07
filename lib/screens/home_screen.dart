import 'dart:ui';

import 'package:clear_sky/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/screens/popular_place_screen.dart';
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

List<Widget> bottomNavScreen = <Widget>[];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  void onTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false, // to prevent the screen move up with the keyboard
      body: Container(
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
              child: _HomeScreenContent(
                index: selectedIndex,
                searchController: searchController,
                height: height,
                width: width,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomContainer(
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
          gap: SizeConfig.getWidth(8),
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: CupertinoIcons.home,
              iconSize: SizeConfig.getIconSize(20),
              text: "Home",
              textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
            ),
            GButton(
              icon: CupertinoIcons.bookmark,
              iconSize: SizeConfig.getIconSize(20),
              text: "Popular",
              textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  final int index;
  final TextEditingController searchController;
  final double height;
  final double width;

  const _HomeScreenContent(
      {required this.index, required this.searchController, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _HomeScreenBody(
          searchController: searchController,
          width: width,
        );
      case 1:
        return PopularScreenBody(
          height: height,
          width: width,
        );
      default:
        return Container();
    }
  }
}

class _HomeScreenBody extends StatelessWidget {
  final TextEditingController searchController;
  final double width;

  const _HomeScreenBody({required this.searchController, required this.width});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
              return ListView(
                padding: EdgeInsets.zero,
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
                            //todo
                            onSubmitted: (inputValue) {
                              context.read<WeatherBloc>().add(
                                    FetchSearchResultsEvent(
                                      searchValue: searchController.text,
                                      // pageRoute: Navigator.pushNamed(context, '/search', arguments: inputValue),
                                    ),
                                  );
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
                  Column(
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
                                            iconSize: SizeConfig.getIconSize(14),
                                            details: DateTimeConversion.formatUnixTimestamp(
                                                state.weatherData!.sys!.sunset!),
                                            fontSize: SizeConfig.getFontSize(14),
                                            fontWeight: FontWeight.w100,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.getHeight(8),
                                          ),
                                          MyIconTextRow(
                                            icon: CupertinoIcons.location,
                                            iconSize: SizeConfig.getIconSize(14),
                                            details: state.weatherData!.name.toString(),
                                            fontSize: SizeConfig.getFontSize(17),
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ],
                                      ),
                                      MyIconTextRow(
                                        icon: CupertinoIcons.cloud,
                                        iconSize: SizeConfig.getIconSize(18),
                                        details: "${state.weatherData!.weather![0].description}",
                                        fontSize: SizeConfig.getFontSize(22),
                                        fontColor: Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  CustomSizedBox(
                                    height: SizeConfig.getHeight(100),
                                    width: SizeConfig.getHeight(100),
                                    child: Image.asset(weatherIcons[state.weatherData!.weather![0].icon] ??
                                        'assets/weather_icons/weather_error.png'),
                                  )
                                ],
                              ),
                            ),
                            MyText(
                              text: "${state.weatherData!.main!.temp}°C",
                              fontSize: SizeConfig.getFontSize(65),
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
                            title: "Current Time",
                            value: CurrentTimeConversion.formatSecondsToReadableTime(
                                state.weatherData!.timezone!),
                            iconImage: "assets/details_icons/time.png",
                            fontSize: SizeConfig.getFontSize(25),
                            letterSpacing: SizeConfig.getWidth(1),
                          ),
                          DetailsRowContainer(
                            title: "Wind",
                            value: "${state.weatherData!.wind!.speed} km/h",
                            iconImage: "assets/details_icons/wind.png",
                            fontSize: SizeConfig.getFontSize(20),
                            letterSpacing: SizeConfig.getWidth(0.5),
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
                            fontSize: SizeConfig.getFontSize(25),
                            letterSpacing: SizeConfig.getWidth(1),
                          ),
                          DetailsRowContainer(
                            title: "Maximum",
                            value: "${state.weatherData!.main!.tempMax}°C",
                            iconImage: "assets/details_icons/hot.png",
                            fontSize: SizeConfig.getFontSize(25),
                            letterSpacing: SizeConfig.getWidth(1),
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
                            MyText(
                              text: "Comfort Level",
                              fontSize: SizeConfig.getFontSize(25),
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
                  )
                ],
              );
            } else if (state.error != null) {
              return CustomContainer(
                height: SizeConfig.getHeight(715),
                width: width,
                image: const DecorationImage(
                    image: AssetImage("assets/errors/home_error.png"), fit: BoxFit.fitWidth),
              );
            } else {
              return CustomContainer(
                height: SizeConfig.getHeight(715),
                width: width,
                image: const DecorationImage(
                    image: AssetImage("assets/errors/home_error.png"), fit: BoxFit.fitWidth),
              );
            }
          },
        ),
      ),
    );
  }
}
