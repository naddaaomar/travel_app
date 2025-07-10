import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:p/screens/search/data/models/CompaniesSearchModel.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/data/models/TravelsSearchModel.dart';
import 'package:p/screens/search/domain/use_cases/search_use_case.dart';



part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase useCases;

  SearchCubit(this.useCases) : super(const SearchState());

  Future<void> search({
    required String type,
    required String query,
    required int pageSize,
    int pageIndex = 1,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      emit(state.copyWith(status: SearchStatus.loading, currentPage: 1));
    }

    try {
      switch (type) {
        case 'Travels':
          final result = await useCases.searchTravels(
            query: query,
            pageSize: pageSize,
            pageIndex: pageIndex,
          );
          result.fold(
                (failure) => emit(state.copyWith(status: SearchStatus.error, errorMessage: failure.message)),
                (data) => emit(state.copyWith(
              status: SearchStatus.success,
              resultType: SearchResultType.travels,
              travels: data,
              currentPage: pageIndex,
            )),
          );
          break;

        case 'Events':
          final result = await useCases.searchEvents(
            query: query,
            pageSize: pageSize,
            pageIndex: 1,
          );
          result.fold(
                (failure) => emit(state.copyWith(status: SearchStatus.error, errorMessage: failure.message)),
                (data) => emit(state.copyWith(
              status: SearchStatus.success,
              resultType: SearchResultType.events,
              events: data,
              currentPage: pageIndex,
            )),
          );
          break;

        case 'Companies':
          final result = await useCases.searchCompanies(
            query: query,
            pageSize: pageSize,
            pageIndex: pageIndex,
          );
          result.fold(
                (failure) => emit(state.copyWith(status: SearchStatus.error, errorMessage: failure.message)),
                (data) => emit(state.copyWith(
              status: SearchStatus.success,
              resultType: SearchResultType.companies,
              companies: data,
              currentPage: pageIndex,
            )),
          );
          break;

        default:
          final result = await useCases.searchAll(
            query: query,
            pageSize: pageSize,
            pageIndex: pageIndex,
          );
          result.fold(
                (failure) => emit(state.copyWith(status: SearchStatus.error, errorMessage: failure.message)),
                (data) => emit(state.copyWith(
              status: SearchStatus.success,
              resultType: SearchResultType.all,
              all: data,
              currentPage: pageIndex,
            )),
          );
      }
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error, errorMessage: e.toString()));
    }
  }

  void loadNextPage(String type, String query, int pageSize) {
    if (type == 'Events') return; //

    final nextPage = state.currentPage + 1;
    final totalPages = switch (state.resultType) {
      SearchResultType.travels => state.travels?.totalPages ?? 1,
      SearchResultType.events => 1, // force skip pagination
      SearchResultType.companies => state.companies?.totalPages ?? 1,
      SearchResultType.all => state.all?.travels?.totalPages ?? 1,
    };

    if (nextPage <= totalPages) {
      search(
        type: type,
        query: query,
        pageSize: pageSize,
        pageIndex: nextPage,
        isLoadMore: true,
      );
    }
  }

}
