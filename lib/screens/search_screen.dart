import 'dart:ui';

import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:clear_sky/widgets/details_row_container.dart';
import 'package:clear_sky/widgets/my_circular_slider.dart';
import 'package:clear_sky/widgets/my_icon_text_row.dart';
import 'package:clear_sky/widgets/my_text.dart';
import 'package:clear_sky/widgets/sunrise_set_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SafeArea(
                              child: CustomContainer(
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
                            ),
                            CustomSizedBox(),
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
                                  Container(
                                    height: SizeConfig.getHeight(120),
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
                                                MyIconTextRow(
                                                  icon: CupertinoIcons.calendar,
                                                  iconSize: 14,
                                                  details: "Mon, 01 april 2024",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                                SizedBox(
                                                  height: SizeConfig.getHeight(8),
                                                ),
                                                MyIconTextRow(
                                                  icon: CupertinoIcons.location,
                                                  iconSize: 14,
                                                  details: "Mon, 01 april 2024",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ],
                                            ),
                                            MyIconTextRow(
                                              icon: CupertinoIcons.cloud,
                                              iconSize: 18,
                                              details: "${state.weatherData.weather![0].description}",
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.ac_unit_outlined,
                                          size: 70,
                                        )
                                      ],
                                    ),
                                  ),
                                  MyText(
                                    text: "${state.weatherData.main!.temp}°C",
                                    fontSize: 65,
                                    fontWeight: FontWeight.w700,
                                  )
                                ],
                              ),
                            ),
                            CustomSizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DetailsRowContainer(
                                  title: "Humidiy",
                                  value: "${state.weatherData.main!.humidity} %",
                                  icon: CupertinoIcons.drop,
                                ),
                                DetailsRowContainer(
                                  title: "Wind",
                                  value: "${state.weatherData.wind!.speed} km/h",
                                  icon: CupertinoIcons.wind,
                                  fontSize: 25,
                                ),
                              ],
                            ),
                            CustomSizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DetailsRowContainer(
                                  title: "Humidiy",
                                  value: "${state.weatherData.main!.tempMin}°C",
                                  icon: CupertinoIcons.thermometer_snowflake,
                                  fontSize: 30,
                                ),
                                DetailsRowContainer(
                                  title: "Humidiy",
                                  value: "${state.weatherData.main!.tempMax}°C",
                                  icon: CupertinoIcons.thermometer_sun,
                                  fontSize: 30,
                                ),
                              ],
                            ),
                            CustomSizedBox(),
                            CustomContainer(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(20)),
                              height: SizeConfig.getHeight(150),
                              width: width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SunRiseSetColumn(
                                    time: "06:45 AM",
                                    imageAddress:
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvtiXfXVlbGafat-ilQrML77x3ageyINjeUY2g0-chh8Cg-kE-nBr3Lv-su9CEZGaz_YE&usqp=CAU",
                                    title: "Sunrise",
                                  ),
                                  SunRiseSetColumn(
                                    time: "06:45 AM",
                                    imageAddress:
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvtiXfXVlbGafat-ilQrML77x3ageyINjeUY2g0-chh8Cg-kE-nBr3Lv-su9CEZGaz_YE&usqp=CAU",
                                    title: "Sunrise",
                                  ),
                                ],
                              ),
                            ),
                            CustomSizedBox(),
                            CustomContainer(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(15)),
                              height: SizeConfig.getHeight(200),
                              width: width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: "Humidity",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  MyCircularSlider(
                                    state: state,
                                  ),
                                ],
                              ),
                            ),
                            CustomSizedBox(),
                          ],
                        ),
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


