part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class InitialBottomNavigationState extends BottomNavigationState {
  final int tabIndex;

  const InitialBottomNavigationState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class SelectedTabIndexState extends BottomNavigationState {
  final int tabIndex;

  const SelectedTabIndexState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class NavigateToHomeState extends BottomNavigationState {
  final String city;

  const NavigateToHomeState({required this.city});

  @override
  List<Object> get props => [city];
}

