part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchSearchResultsEvent extends SearchEvent {

  final Future<Object?> pageRoute;

  const FetchSearchResultsEvent({


    required this.pageRoute,
  });

  @override
  List<Object> get props => [pageRoute];
}
