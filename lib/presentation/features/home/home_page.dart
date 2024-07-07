import 'dart:ui';

import 'package:clear_sky/presentation/features/home/bloc/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:clear_sky/presentation/features/home/widget/home_screen.dart';
import 'package:clear_sky/presentation/features/home/widget/popular_place_screen.dart';
import 'package:clear_sky/presentation/widgets/custom_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        //
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
                color: Colors.orange.shade100,
                image: const DecorationImage(
                  image: AssetImage("assets/bgs/forest_bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
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
            floatingActionButton: CustomContainer(
              height: SizeConfig.getHeight(60),
              width: width,
              color: Colors.white.withOpacity(0.2),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(7)),
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.getWidth(15),
                vertical: SizeConfig.getHeight(28),
              ),
              child: GNav(
                tabBorderRadius: SizeConfig.getWidth(10),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getWidth(10),
                  vertical: SizeConfig.getHeight(13),
                ),
                color: Colors.black,
                tabBackgroundColor: const Color(0xffd7ff26),
                gap: SizeConfig.getWidth(8),
                selectedIndex: selectedIndex,
                onTabChange: onTabChange,
                tabs: [
                  GButton(
                    icon: CupertinoIcons.home,
                    iconSize: SizeConfig.getIconSize(20),
                    text: "Home",
                    textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
                  ),
                  GButton(
                    icon: CupertinoIcons.bookmark,
                    iconSize: SizeConfig.getIconSize(20),
                    text: "Popular",
                    textStyle: TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
