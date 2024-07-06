part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {}

class SuccessSearchState extends SearchState {
  final String query;

  const SuccessSearchState(this.query);

  @override
  List<Object> get props => [query];
}

class ErrorSearchState extends SearchState {
  final String error;

  const ErrorSearchState(this.error);

  @override
  List<Object> get props => [error];
}
