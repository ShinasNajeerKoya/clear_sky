import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';


class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super( InitialBottomNavigationState(tabIndex: 0)) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is TabChangeEvent) {
        emit(SelectedTabIndexState(tabIndex: event.tabIndex));
      }
    });
  }
}



