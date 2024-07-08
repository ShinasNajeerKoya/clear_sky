import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/presentation/features/home/home_page.dart';
import 'package:clear_sky/presentation/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case '/home':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => HomePage(query: args),
          );
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
          title: const Text("error screen"),
        ),
        body: const Center(
          child: Text("ERROR OCCURED"),
        ),
      );
    });
  }
}
