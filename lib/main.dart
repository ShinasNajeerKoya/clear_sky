import 'package:clear_sky/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/bloc/weather_bloc/weather_bloc.dart';
import 'package:clear_sky/routes/generated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
        // BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => BottomNavigationBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: '/',

        onGenerateRoute: RouteGenerator().generateRoute,
        // routes: {
        //   '/': (context) => OnboardingScreen(),
        //   '/home': (context) => HomeScreen(),
        //   '/search': (context) => SearchScreen(),
        //   '/popular': (context) => PopularPlaceScreen(),
        // },
      ),
    );
  }
}
