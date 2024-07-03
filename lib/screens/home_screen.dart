import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/utils/size_configuation.dart';
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
              body: Container(
                height: height,
                width: width,
                color: Colors.yellow,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        // remove this container later
                        padding: EdgeInsets.symmetric(horizontal: 15),

                        color: Colors.orange.shade100,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.getHeight(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(12)),
                              height: SizeConfig.getHeight(55),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
                              ),
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
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: height * 0.4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.getWidth(20),
                              vertical: SizeConfig.getHeight(10),
                            ),
                            width: width,
                            color: Colors.grey.withOpacity(0.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconTextRow(
                                  icon: CupertinoIcons.house,
                                  iconSize: SizeConfig.getIconSize(20),
                                  text: "Place name",
                                  fontWeight: FontWeight.bold,
                                ),
                                Text(
                                  "22°C",
                                  style: TextStyle(
                                    fontSize: SizeConfig.getFontSize(90),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                                IconTextRow(
                                  icon: CupertinoIcons.thermometer,
                                  iconSize: SizeConfig.getIconSize(20),
                                  text: "Feels like : 18°C",
                                  fontSize: SizeConfig.getFontSize(23),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: width,
                          height: height * 0.4,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(20)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                SizeConfig.getRadius(20),
                              ),
                              topRight: Radius.circular(
                                SizeConfig.getRadius(20),
                              ),
                            ),
                          ),
                          child: Container(
                            // color: Colors.red.withOpacity(0.2),
                            child: Column(
                              children: [
                                DetailsContainerRow(
                                  width: width,
                                  height: height,
                                  icon1: CupertinoIcons.drop,
                                  title1: "Humidity",
                                  value1: "46%",
                                  icon2: CupertinoIcons.wind,
                                  title2: "Wind",
                                  value2: "29 km/h",
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                DetailsContainerRow(
                                  width: width,
                                  height: height,
                                  icon1: CupertinoIcons.smoke,
                                  title1: "Humidity",
                                  value1: "2%",
                                  icon2: CupertinoIcons.sun_min,
                                  title2: "Humidity",
                                  value2: "6 of 10",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height * 0.09,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.getWidth(20), vertical: SizeConfig.getHeight(10)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                SizeConfig.getRadius(10),
                              ),
                              topRight: Radius.circular(
                                SizeConfig.getRadius(10),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, -1),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  color: Colors.grey.shade400),
                            ],
                          ),
                          child: GNav(
                            activeColor: Colors.teal.shade900,
                            color: Colors.grey,
                            gap: 5,
                            tabs: [
                              GButton(
                                backgroundColor: Colors.teal.withOpacity(0.1),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                icon: CupertinoIcons.home,
                                iconSize: 20,
                                text: "Home",
                              ),
                              GButton(
                                backgroundColor: Colors.teal.withOpacity(0.1),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                icon: CupertinoIcons.search,
                                iconSize: 20,
                                text: "Search",
                              ),
                              GButton(
                                backgroundColor: Colors.teal.withOpacity(0.1),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                icon: CupertinoIcons.antenna_radiowaves_left_right,
                                text: "Popular",
                                iconSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class DetailsContainerRow extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon1;
  final IconData icon2;
  final String title1;
  final String title2;
  final String value1;
  final String value2;

  const DetailsContainerRow({
    super.key,
    required this.width,
    required this.height,
    required this.icon1,
    required this.icon2,
    required this.title1,
    required this.title2,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsContainer(
          width: width,
          height: height,
          icon: icon1,
          title: title1,
          value: value1,
        ),
        CustomVerticalDivider(
          height: (height * 0.13),
        ),
        DetailsContainer(
          width: width,
          height: height,
          icon: icon2,
          title: title2,
          value: value2,
        ),
      ],
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String title;
  final String value;

  const DetailsContainer({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.4,
      // height: (height * 0.4 - 120) / 2,
      height: (height * 0.13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: SizeConfig.getIconSize(25),
          ),
          Text(
            title,
            style: TextStyle(fontSize: SizeConfig.getFontSize(14)),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.getFontSize(18)),
          )
        ],
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  IconTextRow({
    super.key,
    required this.icon,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.iconSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final customIconSize = iconSize ?? SizeConfig.getIconSize(15);
    final customFontSize = fontSize ?? SizeConfig.getFontSize(18);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: customIconSize,
        ),
        SizedBox(
          width: SizeConfig.getWidth(5),
        ),
        Text(
          text,
          style: TextStyle(fontSize: customFontSize, fontWeight: fontWeight),
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  final double height;

  const CustomVerticalDivider({this.height = 100});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig.getWidth(1),
      height: height,
      color: Colors.grey.shade400,
    );
  }
}
