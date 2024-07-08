import 'package:clear_sky/config/bloc_provider/bloc_provider.dart';
import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/routes/generated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => provideWeatherBloc()),
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
      ),
    );
  }
}
