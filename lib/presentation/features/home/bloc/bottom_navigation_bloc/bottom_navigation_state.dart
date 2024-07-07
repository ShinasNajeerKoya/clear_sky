part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class InitialBottomNavigationState extends BottomNavigationState {
  final int tabIndex;

  InitialBottomNavigationState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

class SelectedTabIndexState extends BottomNavigationState {
  final int tabIndex;

  const SelectedTabIndexState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}


