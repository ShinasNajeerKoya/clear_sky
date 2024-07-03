import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/utils/size_configuation.dart';
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
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(20)),
                            height: SizeConfig.getHeight(180),
                            width: width,
                            color: Colors.grey.withOpacity(0.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.house,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.getWidth(5),
                                    ),
                                    Text(
                                      "Place name",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  "22°C",
                                  style: TextStyle(
                                    fontSize: 90,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.thermometer,
                                      size: 18,
                                    ),
                                    Text(
                                      "Feels like : 18°C",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            width: width,
                            height: height * 0.4,
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
                          ))
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
