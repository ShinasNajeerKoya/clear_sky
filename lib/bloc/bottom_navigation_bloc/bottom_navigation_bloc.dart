import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationPageInitial(tabIndex: 0)) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is TabChangeEvent) {
        emit(BottomNavigationPageInitial(tabIndex: event.tabIndex));
      }
    });
  }

// BottomNavigationBloc() : super(0) {
//   on<BottomNavigateToHomeEvent>((event, emit) async {
//     try {
//       emit(0);
//     } on Exception catch (error) {
//       emit(404);
//     }
//   });
//
//   on<BottomNavigateToPopularEvent>(_onNavigateToPopular);
// }

// void _onNavigateToHome(
//   Future<Object?> pageHomeRoute,
// ) {
//   emit(0);
// }

// void _onNavigateToPopular(BottomNavigateToPopularEvent event, Emitter<int> emit) {
//   emit(1);
// }
}
