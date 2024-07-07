import 'package:clear_sky/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/screens/home_screen.dart';
import 'package:clear_sky/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case '/home':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => HomeScreen(query: args));
        }
        return _errorRoute();


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("error screen"),
        ),
        body: Center(
          child: Text("ERROR OCCURED"),
        ),
      );
    });
  }
}
