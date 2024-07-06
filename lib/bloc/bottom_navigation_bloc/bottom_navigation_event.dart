
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class BottomNavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BottomNavigateToHomeEvent extends BottomNavigationEvent {}

class BottomNavigateToPopularEvent extends BottomNavigationEvent {}


