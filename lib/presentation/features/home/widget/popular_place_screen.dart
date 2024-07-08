import 'dart:developer';

import 'package:clear_sky/config/base_state/base_state.dart';
import 'package:clear_sky/config/bloc_provider/bloc_provider.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_event.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_state.dart';
import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:clear_sky/utils/utils.dart';
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
  List<WeatherBloc> weatherBlocList = [];

  WeatherBloc weatherBlocData = provideWeatherBloc();

  @override
  void initState() {
    super.initState();
    // countries data is from util page
    for (var country in countries) {
      WeatherBloc weatherBloc = provideWeatherBloc();
      weatherBloc.add(GetCityNameEvent(country['searchName']!));
      weatherBlocList.add(weatherBloc);
    }
  }

  @override
  void dispose() {
    for (var weatherBloc in weatherBlocList) {
      weatherBloc.close();
      weatherBlocData.close();
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
            physics: const BouncingScrollPhysics(),
            children: [
              CustomContainer(
                height: SizeConfig.getHeight(70),
                width: widget.width,
                color: Colors.transparent,
              ),
              SizedBox(height: SizeConfig.getHeight(15)),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: countries.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var country = countries[index];
                  return _DetailsContainer(
                    index: index,
                    country: country,
                    widget: widget,
                    weatherBlocList: weatherBlocList,
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 57,
          left: 0,
          right: 0,
          child: _TitleContainer(widget: widget),
        ),
      ],
    );
  }
}

class _TitleContainer extends StatelessWidget {
  const _TitleContainer({
    required this.widget,
  });

  final PopularScreenBody widget;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: SizeConfig.getHeight(50),
      width: widget.width,
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(SizeConfig.getRadius(10)),
      child: const MyText(
        text: "Popular Places",
        fontSize: 23,
        fontWeight: FontWeight.bold,
        fontColor: Colors.black,
      ),
    );
  }
}

class _DetailsContainer extends StatelessWidget {
  final int index;

  const _DetailsContainer({
    required this.country,
    required this.widget,
    required this.weatherBlocList,
    required this.index,
  });

  final Map<String, String> country;
  final PopularScreenBody widget;
  final List<WeatherBloc> weatherBlocList;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        log("ListView container $index is pressed");
        log("can pass query of container ${country['name']!} here");

        context.read<BottomNavigationBloc>().add(NavigateToHomeEvent(city: country['searchName']!));
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
        value: weatherBlocList[index],
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            if (state.dataState == DataState.loading) {
              return const Center(
                  child: MyText(
                text: "Loading values...",
              ));
            } else if (state.dataState == DataState.success) {
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
                                    borderRadius: BorderRadius.circular(SizeConfig.getRadius(5)),
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
                              image: AssetImage(weatherIcons[state.weatherData!.weather![0].icon] ??
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
            } else if (state.dataState == DataState.error) {
              return Center(
                child: MyText(text: state.error ?? 'Unknown error'),
              );
            } else {
              return const Center(
                child: MyText(text: 'Unknown error'),
              );
            }
          },
        ),
      ),
    );
  }
}
