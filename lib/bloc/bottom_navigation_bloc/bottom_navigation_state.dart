part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeScreenState extends BottomNavigationState {}

class PopularScreenState extends BottomNavigationState {}
