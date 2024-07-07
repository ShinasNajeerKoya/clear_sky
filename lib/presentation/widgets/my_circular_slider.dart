import 'package:clear_sky/presentation/features/home/bloc/weather_bloc/weather_state.dart';
import 'package:clear_sky/utils/size_configuration.dart';
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
      initialValue: double.parse("${state.weatherData!.main!.humidity}"),
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(handlerSize: 1.5, trackWidth: 2, progressBarWidth: 10),
        animationEnabled: true,
        size: SizeConfig.getHeight(125),
        customColors: CustomSliderColors(
          trackColor: Colors.grey.shade300,
          progressBarColors: [
            Colors.yellow,
            Colors.teal,
            Colors.pink,
            Colors.purple,
          ],
        ),
        infoProperties: InfoProperties(
            mainLabelStyle: const TextStyle(
              color: Colors.white, // Change the font color of the initial value here
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            bottomLabelText: "Humidity",
            bottomLabelStyle: TextStyle(
              color: Colors.grey.shade700, // Change the font color of the initial value here
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
