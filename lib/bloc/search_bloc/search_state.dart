part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {}

class SuccessSearchState extends SearchState {

  final Future<Object?> pageRoute;

  const SuccessSearchState({

    required this.pageRoute,
  });

  @override
  List<Object> get props => [pageRoute];
}

class ErrorSearchState extends SearchState {
  final String error;

  const ErrorSearchState(this.error);

  @override
  List<Object> get props => [error];
}
