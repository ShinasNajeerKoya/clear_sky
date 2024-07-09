import 'package:clear_sky/config/base_state/base_state.dart';
import 'package:clear_sky/config/bloc_provider/bloc_provider.dart';
import 'package:clear_sky/constants/metric_conversion.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_event.dart';
import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_state.dart';
import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:clear_sky/presentation/widgets/custom_sized_box.dart';
import 'package:clear_sky/presentation/widgets/custom_vertical_divider.dart';
import 'package:clear_sky/presentation/widgets/details_row_container.dart';
import 'package:clear_sky/presentation/widgets/my_circular_slider.dart';
import 'package:clear_sky/presentation/widgets/my_icon_text_row.dart';
import 'package:clear_sky/presentation/widgets/my_text.dart';
import 'package:clear_sky/presentation/widgets/sunrise_set_column.dart';
import 'package:clear_sky/utils/size_configuration.dart';
import 'package:clear_sky/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  final TextEditingController searchController;
  final double height;
  final double width;
  final String query;

  const HomeScreenBody(
      {super.key,
      required this.searchController,
      required this.width,
      required this.query,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: BlocProvider(
        create: (context) => provideWeatherBloc()..add(GetCityNameEvent(query)),
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.dataState == DataState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade700,
                ),
              );
            } else if (state.dataState == DataState.error) {
              return SingleChildScrollView(
                child: CustomContainer(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(width < height
                          ? "assets/errors/search_error_portrait.png"
                          : "assets/errors/search_error_landscape.png"),
                      fit: BoxFit.fitWidth),
                ),
              );
            } else if (state.dataState == DataState.success) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomSizedBox(
                    height: SizeConfig.getHeight(50),
                  ),
                  // searchBar
                  _SearchBar(
                    state: state,
                    searchController: searchController,
                  ),
                  const CustomSizedBox(),
                  Column(
                    children: [
                      // main details area
                      _MainDetailsContainer(
                        state: state,
                        width: width,
                      ),
                      const CustomSizedBox(),
                      // sub details area 1
                      _SubDetailsRowOne(
                        state: state,
                      ),
                      const CustomSizedBox(),
                      // sub details area 2
                      _SubDetailsRowTwo(
                        state: state,
                      ),
                      const CustomSizedBox(),
                      // sunrise sunset section
                      _SunriseSunsetContainer(
                        state: state,
                        width: width,
                      ),
                      const CustomSizedBox(),
                      //humidity section
                      _HumidityContainer(
                        state: state,
                        width: width,
                      ),
                      const CustomSizedBox(),
                    ],
                  )
                ],
              );
            } else {
              return SingleChildScrollView(
                child: CustomContainer(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(width < height
                          ? "assets/errors/homepage_error_portrait.png"
                          : "assets/errors/homepage_error_landscape.png"),
                      fit: BoxFit.fitWidth),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final WeatherState state;

  const _SearchBar({
    required this.searchController,
    required this.state,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
                context.read<WeatherBloc>().add(
                      FetchSearchResultsEvent(
                        searchValue: searchController.text,
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
    );
  }
}

class _MainDetailsContainer extends StatelessWidget {
  final WeatherState state;

  const _MainDetailsContainer({
    required this.width,
    required this.state,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
                          details: DateTimeConversion.formatUnixTimestamp(state.weatherData!.sys!.sunset!),
                          fontSize: SizeConfig.getFontSize(14),
                          fontWeight: FontWeight.w100,
                        ),
                        SizedBox(
                          height: SizeConfig.getHeight(8),
                        ),
                        MyIconTextRow(
                          icon: CupertinoIcons.location,
                          iconSize: SizeConfig.getIconSize(14),
                          details: "${state.weatherData!.name}, ${state.weatherData!.sys!.country}",
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
    );
  }
}

class _SubDetailsRowOne extends StatelessWidget {
  final WeatherState state;

  const _SubDetailsRowOne({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsRowContainer(
          title: "Current Time",
          value: CurrentTimeConversion.formatSecondsToReadableTime(state.weatherData!.timezone!),
          iconImage: "assets/details_icons/time.png",
          fontSize: SizeConfig.getFontSize(20),
          letterSpacing: SizeConfig.getWidth(1),
        ),
        DetailsRowContainer(
          title: "Wind",
          value: "${state.weatherData!.wind!.speed} km/h",
          iconImage: "assets/details_icons/wind.png",
          fontSize: SizeConfig.getFontSize(20),
          letterSpacing: SizeConfig.getWidth(1),
        ),
      ],
    );
  }
}

class _SubDetailsRowTwo extends StatelessWidget {
  final WeatherState state;

  const _SubDetailsRowTwo({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsRowContainer(
          title: "Minimum",
          value: "${state.weatherData!.main!.tempMin}°C",
          iconImage: "assets/details_icons/cold.png",
          fontSize: SizeConfig.getFontSize(20),
          letterSpacing: SizeConfig.getWidth(1),
        ),
        DetailsRowContainer(
          title: "Maximum",
          value: "${state.weatherData!.main!.tempMax}°C",
          iconImage: "assets/details_icons/hot.png",
          fontSize: SizeConfig.getFontSize(20),
          letterSpacing: SizeConfig.getWidth(1),
        ),
      ],
    );
  }
}

class _SunriseSunsetContainer extends StatelessWidget {
  final WeatherState state;

  const _SunriseSunsetContainer({
    required this.width,
    required this.state,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.getHeight(20)),
      height: SizeConfig.getHeight(150),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SunRiseSetColumn(
            title: "Sunrise",
            time: SunRiseToSetTimeConversion.formatUnixTimestamp(state.weatherData!.sys!.sunrise!),
            imageAddress: "assets/sun/sunrise.png",
          ),
          const CustomVerticalDivider(),
          SunRiseSetColumn(
            title: "Sunset",
            time: SunRiseToSetTimeConversion.formatUnixTimestamp(state.weatherData!.sys!.sunset!),
            imageAddress: "assets/sun/sunset.png",
          ),
        ],
      ),
    );
  }
}

class _HumidityContainer extends StatelessWidget {
  final WeatherState state;

  const _HumidityContainer({
    required this.width,
    required this.state,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
    );
  }
}
