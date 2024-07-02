import 'package:clear_sky/repo/weather_repo.dart';
import 'package:clear_sky/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testApiCall();
  runApp(const MyApp());
}

void testApiCall() {
  WeatherRepo.apiCall("udupi");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
