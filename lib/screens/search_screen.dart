import 'dart:ui';

import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:clear_sky/utils/size_configuation.dart';
import 'package:clear_sky/widgets/custom_container.dart';
import 'package:clear_sky/widgets/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              resizeToAvoidBottomInset: false, // it prevents the floating bar to go up with the keyboard
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
                            Expanded(child: CustomContainer()),
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
