part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchSearchResultsEvent extends SearchEvent {
  final String query;

  const FetchSearchResultsEvent({required this.query});

  @override
  List<Object> get props => [query];
}
