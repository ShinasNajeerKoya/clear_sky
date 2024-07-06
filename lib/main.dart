import 'package:clear_sky/bloc/search_bloc/search_bloc.dart';
import 'package:clear_sky/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/screens/home_screen.dart';
import 'package:clear_sky/screens/onboarding_screen.dart';
import 'package:clear_sky/screens/popular_place_screen.dart';
import 'package:clear_sky/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

// void testApiCall() {
//   WeatherRepo.apiCall("udupi");
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/': (context) => OnboardingScreen(),
          '/home': (context) => HomeScreen(),
          '/search': (context) => SearchScreen(),
          '/popular': (context) => PopularPlaceScreen(),
        },
      ),
    );
  }
}
