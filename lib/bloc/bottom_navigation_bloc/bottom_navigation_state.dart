part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  final int tabIndex;

  BottomNavigationState({required this.tabIndex});

  @override
  List<Object> get props => [];
}

class BottomNavigationPageInitial extends BottomNavigationState {
  BottomNavigationPageInitial({required super.tabIndex});
}

// class SuccessHomeScreenState extends BottomNavigationState {
//   SuccessHomeScreenState({required super.tabIndex});
// }
//
// class SuccessPopularScreenState extends BottomNavigationState {
//   SuccessPopularScreenState({required super.tabIndex});
// }

// class ErrorState extends BottomNavigationState {
//   final String error;
//
//   ErrorState(this.error) : super(tabIndex: 0);
//
//
//
//   @override
//   List<Object> get props => [error];
// }
