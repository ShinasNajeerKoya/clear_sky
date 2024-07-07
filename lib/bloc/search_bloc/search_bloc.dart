import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()) {
    on<FetchSearchResultsEvent>((event, emit) async {
      try {
        emit(
          SuccessSearchState(pageRoute: event.pageRoute),
        );
      } on Exception catch (error) {
        emit(ErrorSearchState(error.toString()));
      }
    });
  }
}
