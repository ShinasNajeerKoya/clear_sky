part of 'bottom_navigation_bloc.dart';

class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends BottomNavigationEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class NavigateToHomeEvent extends BottomNavigationEvent {
  final String city;

  const NavigateToHomeEvent({required this.city});

  @override
  List<Object> get props => [city];
}


