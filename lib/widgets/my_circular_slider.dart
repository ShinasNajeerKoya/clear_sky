import 'package:clear_sky/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MyCircularSlider extends StatelessWidget {
  final WeatherState state;

  const MyCircularSlider({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 100,
      initialValue: double.parse("${state.weatherData.main!.humidity}"),
      appearance: CircularSliderAppearance(
          animationEnabled: true,
          size: 120,
          customColors: CustomSliderColors(trackColor: Colors.blue, progressBarColors: [
            Colors.yellow,
            Colors.teal,
            Colors.pink,
            Colors.purple,
          ])),
    );
  }
}
