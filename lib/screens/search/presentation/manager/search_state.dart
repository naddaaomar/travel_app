part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, error }

enum SearchResultType { travels, events, companies, all }

class SearchState {
  final SearchStatus status;
  final String? errorMessage;
  final SearchResultType resultType;

  final TravelsSearchModel? travels;
  final List<EventsSearchModel>? events;
  final CompaniesSearchModel? companies;
  final SearchAllModel? all;

  final int currentPage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.resultType = SearchResultType.all,
    this.errorMessage,
    this.travels,
    this.events,
    this.companies,
    this.all,
    this.currentPage = 1,
  });

  SearchState copyWith({
    SearchStatus? status,
    String? errorMessage,
    SearchResultType? resultType,
    TravelsSearchModel? travels,
    List<EventsSearchModel>? events,
    CompaniesSearchModel? companies,
    SearchAllModel? all,
    int? currentPage,
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      resultType: resultType ?? this.resultType,
      travels: travels ?? this.travels,
      events: events ?? this.events,
      companies: companies ?? this.companies,
      all: all ?? this.all,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
