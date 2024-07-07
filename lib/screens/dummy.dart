// Positioned(
//   bottom: 0,
//   left: 0,
//   right: 0,
//   child: BlocConsumer<BottomNavigationBloc, int>(
//     listener: (context, state) {
//       if (state == 0) {
//         context.read<BottomNavigationBloc>().add(BottomNavigateToHomeEvent(
//             homePageRoute: Navigator.pushReplacementNamed(context, '/home')));
//       } else if (state == 1) {
//         context.read<BottomNavigationBloc>().add(BottomNavigateToPopularEvent(
//             popularPageRoute: Navigator.pushReplacementNamed(context, '/popular')));
//       } else if (state == 404) {}
//     },
//     builder: (context, state) {
//       return CustomContainer(
//         height: SizeConfig.getHeight(60),
//         width: width,
//         color: Colors.white.withOpacity(0.2),
//         padding: EdgeInsets.symmetric(horizontal: SizeConfig.getWidth(7)),
//         margin: EdgeInsets.symmetric(
//           horizontal: SizeConfig.getWidth(15),
//           vertical: SizeConfig.getHeight(28),
//         ),
//         child: GNav(
//           tabBorderRadius: SizeConfig.getWidth(10),
//           padding: EdgeInsets.symmetric(
//             horizontal: SizeConfig.getWidth(10),
//             vertical: SizeConfig.getHeight(13),
//           ),
//           color: Colors.black,
//           tabBackgroundColor: Color(0xffd7ff26),
//           gap: SizeConfig.getWidth(8),
//           selectedIndex: state,
//           onTabChange: (index) {
//             // i am getting error of setstate after dispose, so trying to mount it to the widget tree
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (!mounted) return; // Check if widget is still mounted
//               if (index == 0) {
//                 context.read<BottomNavigationBloc>().add(BottomNavigateToHomeEvent(
//                     pageRoute: Navigator.pushReplacementNamed(context, '/home')));
//                 Navigator.pushReplacementNamed(context, '/home');
//               } else if (index == 1) {
//                 context.read<BottomNavigationBloc>().add(BottomNavigateToPopularEvent());
//                 Navigator.pushReplacementNamed(context, '/popular');
//               }
//             });
//           },
//           tabs: [
//             GButton(
//               icon: CupertinoIcons.home,
//               iconSize: SizeConfig.getIconSize(20),
//               text: "Home",
//               textStyle:
//                   TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
//             ),
//             GButton(
//               icon: CupertinoIcons.bookmark,
//               iconSize: SizeConfig.getIconSize(20),
//               text: "Popular",
//               textStyle:
//                   TextStyle(fontSize: SizeConfig.getFontSize(16), fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
// )


















