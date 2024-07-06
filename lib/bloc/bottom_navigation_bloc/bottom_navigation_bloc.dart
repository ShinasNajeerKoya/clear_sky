import 'package:clear_sky/bloc/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'bottom_navigation_state.dart';

// class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
//   BottomNavigationBloc() : super(HomeScreenState()) {
//     on<BottomNavigateToHomeEvent>((event, emit) {
//       emit(HomeScreenState());
//     });
//     on<BottomNavigateToPopularEvent>((event, emit) {
//       emit(PopularScreenState());
//     });
//   }
// }

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, int> {
  BottomNavigationBloc() : super(0) {
    on<BottomNavigateToHomeEvent>(_onNavigateToHome);
    on<BottomNavigateToPopularEvent>(_onNavigateToPopular);
  }

  void _onNavigateToHome(BottomNavigateToHomeEvent event, Emitter<int> emit) {
    emit(0);
  }

  void _onNavigateToPopular(BottomNavigateToPopularEvent event, Emitter<int> emit) {
    emit(1);
  }
}
