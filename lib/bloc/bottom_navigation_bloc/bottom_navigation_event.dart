part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabChangeEvent extends BottomNavigationEvent{
  final int tabIndex;

  TabChangeEvent({required this.tabIndex});
}

//
// class BottomNavigateToHomeEvent extends BottomNavigationEvent {
//   final Future<Object?> homePageRoute;
//
//   BottomNavigateToHomeEvent({
//     required this.homePageRoute,
//   });
//
//   @override
//   List<Object> get props => [homePageRoute];
// }
//
// class BottomNavigateToPopularEvent extends BottomNavigationEvent {
//   final Future<Object?> popularPageRoute;
//
//   BottomNavigateToPopularEvent({
//     required this.popularPageRoute,
//   });
//
//   @override
//   List<Object> get props => [popularPageRoute];
// }
