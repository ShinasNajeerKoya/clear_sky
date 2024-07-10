import 'dart:ui';

import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/presentation/features/home/widget/custom_bottom_bar.dart';
import 'package:clear_sky/presentation/features/home/widget/home_screen.dart';
import 'package:clear_sky/presentation/features/home/widget/popular_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/size_configuration.dart';

class HomePage extends StatefulWidget {
  final String query;

  const HomePage({super.key, required this.query});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  String selectedCity = '';

// event adding for BNB
  void onTabChange(int index) {
    context.read<BottomNavigationBloc>().add(
          TabChangeEvent(tabIndex: index),
        );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final height = SizeConfig.screenHeight;
    final width = SizeConfig.screenWidth;
    return BlocListener<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {
        if (state is NavigateToHomeState) {
          Navigator.popAndPushNamed(context, '/home', arguments: state.city);
        }
      },
      child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          if (state is SelectedTabIndexState) {
            selectedIndex = state.tabIndex;
          }
          return Scaffold(
            resizeToAvoidBottomInset: false, // to prevent the screen move up with the keyboard
            body: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(width < height
                      ? "assets/bgs/clear_sky_bg_2.png"
                      : "assets/bgs/clear_sky_bg_landscape.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(15)),
                    child: _HomePageContent(
                      index: selectedIndex,
                      searchController: searchController,
                      height: height,
                      width: width,
                      query: widget.query,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: CustomBottomBar(
              width: width,
              selectedIndex: selectedIndex,
              onTabChange: onTabChange,
            ),
          );
        },
      ),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  final int index;
  final TextEditingController searchController;
  final double height;
  final double width;
  final String query;

  const _HomePageContent(
      {required this.index,
      required this.searchController,
      required this.width,
      required this.height,
      required this.query});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return HomeScreenBody(
          searchController: searchController,
          height: height,
          width: width,
          query: query,
        );
      case 1:
        return PopularScreenBody(
          height: height,
          width: width,
        );
      default:
        return Container();
    }
  }
}
