import 'dart:ui';

import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/utils/utils.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularPlaceScreen extends StatefulWidget {
  const PopularPlaceScreen({super.key});

  @override
  State<PopularPlaceScreen> createState() => _PopularPlaceScreenState();
}

class _PopularPlaceScreenState extends State<PopularPlaceScreen> {
  TextEditingController searchController = TextEditingController();

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
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              image: DecorationImage(
                  image: AssetImage("assets/bgs/forest_bg.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              height: height,
              width: width,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(
                        height: SizeConfig.getHeight(50),
                        width: width,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.getHeight(15)),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                    itemCount: countries.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var country = countries[index];
                      return BlocProvider.value(
                        value: weatherBlocs[index],
                        child: BlocConsumer<WeatherBloc, WeatherState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state.weatherStatus == WeatherStatus.loading) {
                              return CustomContainer(
                                height: SizeConfig.getHeight(180),
                                width: width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(15)),
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                                margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                                child: Center(child: Text("Loading...")),
                              );
                            }
                            if (state.weatherStatus == WeatherStatus.loaded) {
                              return CustomContainer(
                                height: SizeConfig.getHeight(180),
                                width: width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.getWidth(20),
                                  vertical: SizeConfig.getHeight(15),
                                ),
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                                margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                                child: Row(
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
                                                          image: AssetImage(country['flag']!),
                                                          fit: BoxFit.cover),
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
                                                      state.weatherData.timezone!),
                                                  fontSize: SizeConfig.getFontSize(20),
                                                  letterSpacing: 4,
                                                )
                                              ],
                                            ),
                                          ),
                                          MyText(text: "Feels like : ${state.weatherData.main!.feelsLike}°C")
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
                                                    weatherIcons[state.weatherData.weather![0].icon] ??
                                                        'assets/weather_icons/weather_error.png')),
                                          ),
                                          MyText(
                                            text: "${state.weatherData.main!.temp}°C",
                                            fontSize: SizeConfig.getFontSize(25),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          MyText(
                                            text: "${state.weatherData.weather![0].description}",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (state.weatherStatus == WeatherStatus.error) {
                              return CustomContainer(
                                height: SizeConfig.getHeight(180),
                                width: width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(15)),
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                                margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                                child: Center(child: Text(state.error)),
                              );
                            }
                            return CustomContainer(
                              height: SizeConfig.getHeight(180),
                              width: width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(15)),
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                              margin: EdgeInsets.only(bottom: SizeConfig.getHeight(15)),
                              child: Center(child: Text("Unknown error")),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 57,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  height: SizeConfig.getHeight(50),
                  width: SizeConfig.getHeight(50),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                ),
                Expanded(
                  child: CustomContainer(
                    height: SizeConfig.getHeight(50),
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                    margin: EdgeInsets.only(left: SizeConfig.getWidth(15)),
                    child: MyText(
                      text: "Popular Places",
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
